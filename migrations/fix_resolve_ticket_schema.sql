-- Fix resolve_ticket function schema mismatch
-- Issue: Function tries to insert into non-existent prerequisites/success_indicators columns
-- Run this in Supabase Dashboard → SQL Editor

CREATE OR REPLACE FUNCTION resolve_ticket(
    p_ticket_id TEXT,
    p_solution_data JSONB
) RETURNS JSONB AS $$
DECLARE
    v_ticket RECORD;
    v_knowledge_id INTEGER;
    v_result JSONB;
BEGIN
    -- Get ticket info
    SELECT * INTO v_ticket
    FROM troubleshooting_sessions
    WHERE ticket_id = p_ticket_id AND status != 'resolved';

    IF NOT FOUND THEN
        RETURN jsonb_build_object('error', 'Ticket not found or already resolved');
    END IF;

    -- Update ticket status
    UPDATE troubleshooting_sessions
    SET
        status = 'resolved',
        solution = p_solution_data->>'solution',
        solution_data = p_solution_data,
        resolved_at = NOW()
    WHERE ticket_id = p_ticket_id;

    -- Auto-contribute to knowledge base (bypass moderation for ticket-based solutions)
    -- Fixed: removed prerequisites and success_indicators columns (don't exist in schema)
    INSERT INTO knowledge_entries (
        query,
        category,
        hit_frequency,
        solutions,
        common_pitfalls,
        success_rate,
        claude_version,
        last_verified,
        source_ticket_id
    ) VALUES (
        v_ticket.problem,
        v_ticket.category,
        'MEDIUM (from ticket)',
        p_solution_data->'solutions',
        COALESCE(p_solution_data->>'common_pitfalls', ''),
        COALESCE((p_solution_data->>'success_rate')::NUMERIC, 0.90),
        'sonnet-4',
        NOW(),
        p_ticket_id
    )
    RETURNING id INTO v_knowledge_id;

    -- Mark as auto-contributed
    UPDATE troubleshooting_sessions
    SET auto_contributed = TRUE
    WHERE ticket_id = p_ticket_id;

    RETURN jsonb_build_object(
        'success', TRUE,
        'ticket_id', p_ticket_id,
        'knowledge_id', v_knowledge_id,
        'message', 'Solution added to knowledge base automatically'
    );
END;
$$ LANGUAGE plpgsql;
