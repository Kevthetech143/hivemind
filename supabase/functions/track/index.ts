// Supabase Edge Function: Track User Events
// Handles command copies and repeat searches for implicit quality signals

import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    // Initialize Supabase client
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Parse tracking event
    const { event_type, solution_query, solution_id } = await req.json()

    if (!event_type || (!solution_query && !solution_id)) {
      return new Response(
        JSON.stringify({ error: 'event_type and (solution_query or solution_id) required' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Helper to find entry by ID or query
    async function findEntry(selectFields: string) {
      if (solution_id) {
        return await supabaseClient
          .from('knowledge_entries')
          .select(selectFields)
          .eq('id', solution_id)
          .single()
      } else {
        return await supabaseClient
          .from('knowledge_entries')
          .select(selectFields)
          .eq('query', solution_query)
          .single()
      }
    }

    // Rate limiting for voting events (stricter limits)
    if (event_type === 'solution_success' || event_type === 'solution_failure') {
      const clientIP = req.headers.get('x-forwarded-for')?.split(',')[0] ||
                       req.headers.get('x-real-ip') ||
                       'unknown'

      const { data: rateLimitOk } = await supabaseClient.rpc('check_rate_limit', {
        p_ip_address: clientIP,
        p_endpoint: 'track_vote',
        p_limit: 20, // 20 votes per hour to prevent abuse
        p_window_minutes: 60
      })

      if (!rateLimitOk) {
        return new Response(
          JSON.stringify({ error: 'Rate limit exceeded. Please try again later.' }),
          { status: 429, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }
    }

    if (event_type === 'command_copy') {
      // Increment command_copy_count
      const { error } = await supabaseClient.rpc('increment_command_copy', {
        solution_query_text: solution_query
      })

      if (error) {
        console.error('Command copy tracking error:', error)
        return new Response(
          JSON.stringify({ error: 'Tracking failed' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({ success: true, tracked: 'command_copy' }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    if (event_type === 'repeat_search') {
      // Get current stats
      const { data: entry, error: fetchError } = await findEntry('id, view_count, repeat_search_rate')

      if (fetchError || !entry) {
        return new Response(
          JSON.stringify({ error: 'Solution not found' }),
          { status: 404, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      // Calculate new repeat rate (weighted average)
      const view_count = entry.view_count || 1
      const current_rate = entry.repeat_search_rate || 0
      const new_rate = ((current_rate * view_count) + 1) / (view_count + 1)

      // Update repeat_search_rate
      const { error: updateError } = await supabaseClient
        .from('knowledge_entries')
        .update({ repeat_search_rate: new_rate })
        .eq('id', entry.id)

      if (updateError) {
        console.error('Repeat search tracking error:', updateError)
        return new Response(
          JSON.stringify({ error: 'Tracking failed' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({ success: true, tracked: 'repeat_search', new_rate }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    if (event_type === 'solution_success') {
      // Get current thumbs_up count
      const { data: entry, error: fetchError } = await findEntry('id, thumbs_up')

      if (fetchError || !entry) {
        return new Response(
          JSON.stringify({ error: 'Solution not found' }),
          { status: 404, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      // Increment thumbs_up count
      const { error } = await supabaseClient
        .from('knowledge_entries')
        .update({ thumbs_up: (entry.thumbs_up || 0) + 1 })
        .eq('id', entry.id)

      if (error) {
        console.error('Thumbs up tracking error:', error)
        return new Response(
          JSON.stringify({ error: 'Tracking failed' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({ success: true, tracked: 'solution_success', new_count: (entry.thumbs_up || 0) + 1 }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    if (event_type === 'solution_failure') {
      // Get current thumbs_down count
      const { data: entry, error: fetchError } = await findEntry('id, thumbs_down')

      if (fetchError || !entry) {
        return new Response(
          JSON.stringify({ error: 'Solution not found' }),
          { status: 404, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      // Increment thumbs_down count
      const { error } = await supabaseClient
        .from('knowledge_entries')
        .update({ thumbs_down: (entry.thumbs_down || 0) + 1 })
        .eq('id', entry.id)

      if (error) {
        console.error('Thumbs down tracking error:', error)
        return new Response(
          JSON.stringify({ error: 'Tracking failed' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({ success: true, tracked: 'solution_failure', new_count: (entry.thumbs_down || 0) + 1 }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    return new Response(
      JSON.stringify({ error: 'Invalid event_type. Use: command_copy, repeat_search, solution_success, solution_failure' }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    console.error('Function error:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
