// Supabase Edge Function: List and Get Flows
// Handles flow browsing and retrieval

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

    // Parse request
    const { action = 'list', category = null, flow_id = null, limit = 50 } = await req.json()

    const startTime = performance.now()

    if (action === 'list') {
      // List all flows, optionally filtered by category
      const { data, error } = await supabaseClient.rpc('list_flows', {
        category_filter: category,
        result_limit: limit
      })

      if (error) {
        console.error('List flows error:', error)
        return new Response(
          JSON.stringify({ error: 'Failed to list flows' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      const searchTime = performance.now() - startTime

      // Get unique categories for filtering
      const { data: categories } = await supabaseClient
        .from('knowledge_entries')
        .select('category')
        .eq('type', 'flow')
        .order('category')

      const uniqueCategories = [...new Set(categories?.map(c => c.category) || [])]

      return new Response(
        JSON.stringify({
          action: 'list',
          flows: data || [],
          total_count: data?.length || 0,
          categories: uniqueCategories,
          filter: { category },
          query_metadata: {
            search_time_ms: Math.round(searchTime * 100) / 100
          }
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    if (action === 'get' && flow_id) {
      // Get a specific flow by ID
      const { data, error } = await supabaseClient
        .from('knowledge_entries')
        .select('*')
        .eq('id', flow_id)
        .eq('type', 'flow')
        .single()

      if (error || !data) {
        return new Response(
          JSON.stringify({ error: 'Flow not found' }),
          { status: 404, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      const searchTime = performance.now() - startTime

      // Increment view count
      await supabaseClient
        .from('knowledge_entries')
        .update({ view_count: (data.view_count || 0) + 1 })
        .eq('id', flow_id)

      return new Response(
        JSON.stringify({
          action: 'get',
          flow: {
            id: data.id,
            query: data.query,
            category: data.category,
            solutions: data.solutions,
            common_pitfalls: data.common_pitfalls,
            prerequisites: data.prerequisites,
            success_indicators: data.success_indicators,
            view_count: data.view_count,
            created_at: data.created_at
          },
          query_metadata: {
            search_time_ms: Math.round(searchTime * 100) / 100
          }
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    return new Response(
      JSON.stringify({ error: 'Invalid action. Use "list" or "get"' }),
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
