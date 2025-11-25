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
    // Initialize Supabase client first
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    // Get client IP
    const clientIP = req.headers.get('x-forwarded-for')?.split(',')[0] ||
                     req.headers.get('x-real-ip') ||
                     'unknown'

    // CHECK 1: IP BAN CHECK (before anything else)
    const { data: isBanned } = await supabaseClient.rpc('is_ip_banned', {
      p_ip_address: clientIP
    })

    if (isBanned) {
      // Log failed attempt
      await supabaseClient.rpc('log_contribution_attempt', {
        p_ip_address: clientIP,
        p_endpoint: 'contribute',
        p_success: false
      })

      return new Response(
        JSON.stringify({ error: 'Access denied. Your IP has been banned.' }),
        { status: 403, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

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

    // CHECK 2: INPUT SANITIZATION
    const sanitize = async (text: string): Promise<string> => {
      const { data } = await supabaseClient.rpc('sanitize_text', { p_text: text })
      return data || text
    }

    contribution.query = await sanitize(contribution.query)
    contribution.prerequisites = await sanitize(contribution.prerequisites)
    contribution.success_indicators = await sanitize(contribution.success_indicators)
    contribution.common_pitfalls = contribution.common_pitfalls ? await sanitize(contribution.common_pitfalls) : ''

    // Get or create contributor
    const contributor_email = contribution.contributor_email || 'anonymous'

    // CHECK 3: RATE LIMITING
    const { data: rateLimitOk } = await supabaseClient.rpc('check_rate_limit', {
      p_ip_address: clientIP,
      p_endpoint: 'contribute',
      p_limit: 5,  // 5 contributions per hour
      p_window_minutes: 60
    })

    if (!rateLimitOk) {
      // Log failed attempt
      await supabaseClient.rpc('log_contribution_attempt', {
        p_ip_address: clientIP,
        p_endpoint: 'contribute',
        p_success: false
      })

      return new Response(
        JSON.stringify({ error: 'Rate limit exceeded. Limit: 5 contributions/hour.' }),
        { status: 429, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

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
        status: 'pending_review'
      })
      .select('id')
      .single()

    if (error) {
      console.error('Insert error:', error)

      // Log failed attempt
      await supabaseClient.rpc('log_contribution_attempt', {
        p_ip_address: clientIP,
        p_endpoint: 'contribute',
        p_success: false
      })

      return new Response(
        JSON.stringify({ error: 'Submission failed' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Log successful attempt
    await supabaseClient.rpc('log_contribution_attempt', {
      p_ip_address: clientIP,
      p_endpoint: 'contribute',
      p_success: true
    })

    const contribution_id = `CONTRIB_${String(data.id).padStart(8, '0')}`

    return new Response(
      JSON.stringify({
        success: true,
        contribution_id,
        status: 'pending_review',
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
