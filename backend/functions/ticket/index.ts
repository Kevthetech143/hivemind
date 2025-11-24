// Supabase Edge Function: Ticket Operations
// Handles troubleshooting ticket updates and resolution

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

    const { action, ticket_id, step, result, solution_data } = await req.json()

    if (!action || !ticket_id) {
      return new Response(
        JSON.stringify({ error: 'action and ticket_id required' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // GET ticket status
    if (action === 'get') {
      const { data: ticket, error } = await supabaseClient
        .from('troubleshooting_sessions')
        .select('*')
        .eq('ticket_id', ticket_id)
        .single()

      if (error || !ticket) {
        return new Response(
          JSON.stringify({ error: 'Ticket not found' }),
          { status: 404, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({ ticket }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // UPDATE ticket with step tried
    if (action === 'update') {
      if (!step || !result) {
        return new Response(
          JSON.stringify({ error: 'step and result required for update action' }),
          { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      const { data: success } = await supabaseClient.rpc('update_ticket_steps', {
        p_ticket_id: ticket_id,
        p_step: step,
        p_result: result
      })

      if (!success) {
        return new Response(
          JSON.stringify({ error: 'Failed to update ticket' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({
          success: true,
          ticket_id,
          message: 'Step recorded'
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // RESOLVE ticket and auto-contribute to knowledge base
    if (action === 'resolve') {
      if (!solution_data) {
        return new Response(
          JSON.stringify({ error: 'solution_data required for resolve action' }),
          { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      const { data: resolveResult, error } = await supabaseClient.rpc('resolve_ticket', {
        p_ticket_id: ticket_id,
        p_solution_data: solution_data
      })

      if (error || !resolveResult || resolveResult.error) {
        return new Response(
          JSON.stringify({ error: resolveResult?.error || error?.message || 'Failed to resolve ticket' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify(resolveResult),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Invalid action
    return new Response(
      JSON.stringify({ error: 'Invalid action. Must be: get, update, or resolve' }),
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
