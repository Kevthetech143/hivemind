// Supabase Edge Function: Admin Operations
// Handles approval of pending contributions

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
    const { action, contribution_ids, reviewer_notes } = await req.json()

    // Initialize Supabase client with service role (has write access)
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    if (action === 'approve') {
      // Approve contributions
      const { error: updateError } = await supabaseClient
        .from('pending_contributions')
        .update({
          status: 'approved',
          reviewed_at: new Date().toISOString(),
          reviewer_notes: reviewer_notes || 'Approved'
        })
        .in('id', contribution_ids)

      if (updateError) {
        throw new Error(`Failed to approve: ${updateError.message}`)
      }

      // Get approved contributions
      const { data: contributions, error: fetchError } = await supabaseClient
        .from('pending_contributions')
        .select('*')
        .in('id', contribution_ids)
        .eq('status', 'approved')

      if (fetchError) {
        throw new Error(`Failed to fetch: ${fetchError.message}`)
      }

      // Insert into knowledge base
      const entries = contributions.map(c => ({
        query: c.query,
        category: c.category,
        hit_frequency: c.hit_frequency,
        solutions: c.solutions,
        prerequisites: c.prerequisites,
        success_indicators: c.success_indicators,
        common_pitfalls: c.common_pitfalls,
        success_rate: c.success_rate,
        claude_version: 'sonnet-4',
        last_verified: new Date().toISOString()
      }))

      const { error: insertError } = await supabaseClient
        .from('knowledge_entries')
        .insert(entries)

      if (insertError) {
        throw new Error(`Failed to insert: ${insertError.message}`)
      }

      return new Response(
        JSON.stringify({
          success: true,
          message: `Approved and added ${contribution_ids.length} contributions to knowledge base`,
          contribution_ids
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    return new Response(
      JSON.stringify({ error: 'Invalid action' }),
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
