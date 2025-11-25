// Supabase Edge Function: Contribute Solution
// Handles solution submissions to moderation queue

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
    // Parse contribution
    const contribution = await req.json()

    // Validate required fields
    const required = ['query', 'category', 'solutions', 'prerequisites', 'success_indicators']
    for (const field of required) {
      if (!contribution[field]) {
        return new Response(
          JSON.stringify({ error: `Missing required field: ${field}` }),
          { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }
    }

    // Initialize Supabase client
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Rate limiting for contributions (prevent spam)
    const clientIP = req.headers.get('x-forwarded-for')?.split(',')[0] ||
                     req.headers.get('x-real-ip') ||
                     'unknown'

    const { data: rateLimitOk } = await supabaseClient.rpc('check_rate_limit', {
      p_ip_address: clientIP,
      p_endpoint: 'contribute',
      p_limit: 50, // 50 contributions per hour (increased from 5)
      p_window_minutes: 60
    })

    if (!rateLimitOk) {
      return new Response(
        JSON.stringify({ error: 'Rate limit exceeded. Please try again later.' }),
        { status: 429, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Get contributor email (optional, for contact)
    const contributor_email = contribution.contributor_email || 'anonymous'

    // Compute success_rate from solutions
    const solutions = contribution.solutions
    const success_rate = solutions.length > 0
      ? Math.max(...solutions.map((s: any) => s.percentage || 0)) / 100.0
      : 0.0

    // Insert into pending_contributions
    const { data, error } = await supabaseClient
      .from('pending_contributions')
      .insert({
        contributor_email: contributor_email,
        query: contribution.query,
        category: contribution.category,
        hit_frequency: contribution.hit_frequency || 'MEDIUM (estimated)',
        solutions: contribution.solutions,
        prerequisites: contribution.prerequisites,
        success_indicators: contribution.success_indicators,
        common_pitfalls: contribution.common_pitfalls || '',
        success_rate: success_rate,
        status: 'pending'
      })
      .select('id')
      .single()

    if (error) {
      console.error('Insert error:', error)
      return new Response(
        JSON.stringify({ error: 'Submission failed' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const contribution_id = `CONTRIB_${String(data.id).padStart(8, '0')}`

    return new Response(
      JSON.stringify({
        success: true,
        contribution_id,
        status: 'pending',
        estimated_review_time: '24-48 hours',
        message: 'Thank you for contributing! Your solution will be reviewed by our team.'
      }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    console.error('Function error:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
