// Supabase Edge Function: Search Knowledge Base
// Handles full-text search with ranking and tracking

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

    // Rate limiting check
    const clientIP = req.headers.get('x-forwarded-for')?.split(',')[0] ||
                     req.headers.get('x-real-ip') ||
                     'unknown'

    const { data: rateLimitOk } = await supabaseClient.rpc('check_rate_limit', {
      p_ip_address: clientIP,
      p_endpoint: 'search',
      p_limit: 100, // 100 requests per hour
      p_window_minutes: 60
    })

    if (!rateLimitOk) {
      return new Response(
        JSON.stringify({ error: 'Rate limit exceeded. Please try again later.' }),
        { status: 429, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Parse request
    const { query, max_results = 5 } = await req.json()

    if (!query) {
      return new Response(
        JSON.stringify({ error: 'query parameter required' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const startTime = performance.now()

    // Full-text search using Postgres tsvector
    const { data: results, error } = await supabaseClient.rpc('search_knowledge', {
      search_query: query,
      result_limit: max_results
    })

    if (error) {
      console.error('Search error:', error)
      return new Response(
        JSON.stringify({ error: 'Search failed' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const searchTime = performance.now() - startTime

    // No results found - auto-create troubleshooting ticket
    if (!results || results.length === 0) {
      // Infer category from query keywords
      const queryLower = query.toLowerCase()
      let category = 'general'

      if (queryLower.includes('mcp') || queryLower.includes('server') || queryLower.includes('connection')) {
        category = 'mcp-troubleshooting'
      } else if (queryLower.includes('playwright') || queryLower.includes('browser') || queryLower.includes('click') || queryLower.includes('selector')) {
        category = 'web-automation'
      } else if (queryLower.includes('supabase') || queryLower.includes('database') || queryLower.includes('postgres') || queryLower.includes('rls')) {
        category = 'database'
      } else if (queryLower.includes('auth') || queryLower.includes('login') || queryLower.includes('sign in') || queryLower.includes('token')) {
        category = 'authentication'
      } else if (queryLower.includes('svelte') || queryLower.includes('react') || queryLower.includes('component')) {
        category = 'frontend'
      }

      // Auto-create ticket
      const { data: ticket } = await supabaseClient.rpc('start_troubleshooting_ticket', {
        p_problem: query,
        p_category: category
      })

      return new Response(
        JSON.stringify({
          query,
          primary_solution: null,
          confidence: 0.0,
          related_solutions: [],
          environment_checks: [],
          validation_steps: [],
          community_stats: {
            total_hits: 0,
            success_rate: 0,
            last_updated: null
          },
          query_metadata: {
            total_matches: 0,
            search_method: 'no_results',
            search_time_ms: searchTime
          },
          ticket: {
            ticket_id: ticket.ticket_id,
            status: 'open',
            category: ticket.category,
            checklist: ticket.checklist,
            message: `No solutions found. I've opened ${ticket.ticket_id} to systematically troubleshoot this. Let's work through the checklist below, and I'll auto-add the solution to the knowledge base when we're done.`
          }
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Primary solution (best match)
    const primary = results[0]

    // Track view for primary solution
    await supabaseClient
      .from('knowledge_entries')
      .update({ view_count: primary.view_count + 1 })
      .eq('id', primary.id)

    // Calculate confidence based on search rank
    let confidence = 0.85
    if (primary.search_rank && primary.search_rank < -0.1) {
      confidence = 0.6
    } else if (primary.search_rank && primary.search_rank < -0.05) {
      confidence = 0.75
    }

    // Get prerequisites
    const { data: prereqs } = await supabaseClient
      .from('prerequisites')
      .select('prerequisite')
      .eq('entry_id', primary.id)
      .limit(3)

    const environment_checks = (prereqs || []).map(p => ({
      prerequisite: p.prerequisite,
      detected_status: 'unknown',
      fix_if_missing: `Ensure ${p.prerequisite} is available`
    }))

    // Get success indicators
    const { data: indicators } = await supabaseClient
      .from('success_indicators')
      .select('indicator')
      .eq('entry_id', primary.id)
      .limit(3)

    const validation_steps = (indicators || []).map(i => i.indicator)

    // Parse hit frequency for stats
    const hitFreq = primary.hit_frequency || 'MEDIUM'
    let totalHits = 50
    if (hitFreq.includes('HIGH')) totalHits = 200
    else if (hitFreq.includes('LOW')) totalHits = 10

    // Related solutions (skip first one since it's primary)
    const related_solutions = results.slice(1, 4).map((rel: any) => ({
      similarity_score: rel.search_rank ? Math.abs(rel.search_rank) : 0.5,
      entry: {
        id: rel.id,
        query: rel.query,
        category: rel.category,
        solutions: rel.solutions
      }
    }))

    // Track related solution views
    for (const rel of related_solutions) {
      await supabaseClient
        .from('knowledge_entries')
        .update({ view_count: supabaseClient.rpc('increment', { row_id: rel.entry.id }) })
        .eq('id', rel.entry.id)
    }

    // Build response
    const response = {
      query,
      primary_solution: {
        id: primary.id,
        query: primary.query,
        category: primary.category,
        hit_frequency: primary.hit_frequency,
        solutions: primary.solutions,
        prerequisites: prereqs?.map(p => p.prerequisite).join(', ') || '',
        success_indicators: indicators?.map(i => i.indicator).join(', ') || '',
        common_pitfalls: primary.common_pitfalls
      },
      confidence: Math.round(confidence * 100) / 100,
      related_solutions,
      environment_checks,
      validation_steps,
      community_stats: {
        total_hits: totalHits,
        success_rate: primary.success_rate || 0.75,
        last_updated: primary.updated_at || primary.created_at
      },
      query_metadata: {
        total_matches: results.length,
        search_method: 'postgres_fts',
        search_time_ms: Math.round(searchTime * 100) / 100
      }
    }

    return new Response(
      JSON.stringify(response),
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
