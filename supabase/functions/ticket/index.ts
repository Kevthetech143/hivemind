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

    const { action, ticket_id, step, result, solution_data, pending_id } = await req.json()

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

    // RESOLVE ticket and route to pending queue (not main KB)
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

    // CONFIRM a pending solution (user says "clauderepo: worked" after resolving ticket)
    if (action === 'confirm_pending') {
      if (!pending_id) {
        return new Response(
          JSON.stringify({ error: 'pending_id required for confirm_pending action' }),
          { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      const { data: graduated, error } = await supabaseClient.rpc('confirm_pending_solution', {
        p_pending_id: pending_id
      })

      if (error) {
        return new Response(
          JSON.stringify({ error: error.message }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({
          success: true,
          graduated: graduated,
          message: graduated
            ? 'Solution verified and added to knowledge base!'
            : 'Confirmation recorded. Need 1 more confirmation to graduate.'
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // ADMIN APPROVE a pending solution (fast-track to KB)
    if (action === 'admin_approve') {
      if (!pending_id) {
        return new Response(
          JSON.stringify({ error: 'pending_id required for admin_approve action' }),
          { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      const { data: new_id, error } = await supabaseClient.rpc('admin_approve_solution', {
        p_pending_id: pending_id
      })

      if (error) {
        return new Response(
          JSON.stringify({ error: error.message }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({
          success: true,
          knowledge_entry_id: new_id,
          message: 'Solution approved and added to knowledge base!'
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // LIST pending solutions (for admin review)
    if (action === 'list_pending') {
      const { data: pending, error } = await supabaseClient
        .from('pending_ticket_solutions')
        .select('*')
        .eq('status', 'pending')
        .order('created_at', { ascending: false })
        .limit(20)

      if (error) {
        return new Response(
          JSON.stringify({ error: error.message }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      return new Response(
        JSON.stringify({ pending_solutions: pending }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Invalid action
    return new Response(
      JSON.stringify({ error: 'Invalid action. Must be: get, update, resolve, confirm_pending, admin_approve, or list_pending' }),
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
