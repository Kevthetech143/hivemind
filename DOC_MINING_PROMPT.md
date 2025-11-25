# Documentation Mining Prompt for AI Agent

## Your Mission
You are tasked with mining **official documentation** from Anthropic, OpenAI, Supabase, and other platforms to extract troubleshooting solutions and common errors. Your goal is to populate a knowledge base with high-quality, verified solutions sourced directly from official docs.

## Target Documentation Sources

### Priority 1: AI Platforms
- **Anthropic Claude Docs**: https://docs.anthropic.com/
  - API errors, rate limits, streaming issues, token limits
  - Claude Code docs: https://code.claude.com/docs/
  - Bedrock integration errors

- **OpenAI API Docs**: https://platform.openai.com/docs/
  - Error codes reference
  - Rate limiting guide
  - Authentication issues
  - Model-specific errors (GPT-4, GPT-3.5)

### Priority 2: Backend/Database
- **Supabase Docs**: https://supabase.com/docs
  - Edge Functions errors
  - Postgres/RLS issues
  - Authentication problems
  - Real-time subscription errors

### Priority 3: Tools & Frameworks
- **Model Context Protocol (MCP)**: https://modelcontextprotocol.io/
  - Server connection issues
  - Transport errors (stdio, SSE, HTTP)
  - Tool/resource registration

- **Playwright Docs**: https://playwright.dev/
  - Browser launch failures
  - Timeout errors
  - Selector issues

## What to Extract

For each error/problem documented, extract:

1. **query** (string): The error message or problem description
   - Use exact error codes when available (e.g., "Error 429: Rate limit exceeded")
   - Make it searchable (what user would type)

2. **category** (string): Category of the problem
   - Examples: `ai-api`, `mcp-troubleshooting`, `supabase`, `postgres`, `playwright`

3. **hit_frequency** (enum): How common is this issue?
   - `VERY_HIGH`, `HIGH`, `MEDIUM`, `LOW`
   - Base on: presence in "Common Errors" section, FAQ mentions, troubleshooting prominence

4. **solutions** (JSONB array): Ranked solutions from docs
   ```json
   [
     {
       "solution": "Step-by-step solution text",
       "percentage": 90,
       "note": "Context or clarification",
       "command": "exact command to run (optional)"
     }
   ]
   ```
   - Sort by effectiveness (most reliable first)
   - Include percentage estimate (80-95% for official doc solutions)

5. **prerequisites** (string): What's needed before applying solution
   - "Valid API key, Sufficient account credit"
   - "Supabase CLI v1.50+, Docker running"

6. **success_indicators** (string): How to verify solution worked
   - "API returns 200 status, No error in logs"
   - "Browser launches successfully, Test passes"

7. **common_pitfalls** (string): What users get wrong
   - Extract from "Common Mistakes", "Important Notes", warning boxes
   - Look for ⚠️ warning callouts in docs

8. **success_rate** (float): 0.0 to 1.0
   - Official doc solutions: 0.85-0.95
   - Experimental/beta features: 0.70-0.80

9. **source_url** (string): Direct link to documentation page
   - Link to specific section if possible

10. **pattern_id** (integer, optional): Link to pattern if applicable
    - Only if error matches existing pattern (PATH_INHERITANCE, STREAMING_BUFFER_CONFLICT, etc.)

## Extraction Strategy

### 1. Error Reference Pages
Start with official error code references:
- Anthropic: Error codes documentation
- OpenAI: API errors guide
- Supabase: Common errors page

**Example from Anthropic docs**:
```
Error 529: Overloaded
└─ Solution 1: "Retry request with exponential backoff" (90%)
└─ Solution 2: "Wait 60 seconds and retry" (80%)
└─ Prerequisites: Valid API key
└─ Success indicator: Request returns 200 status
```

### 2. Troubleshooting Guides
Mine "Troubleshooting" sections:
- Look for "If X happens, try Y" patterns
- Extract multi-step solutions as separate percentages

**Example from Supabase docs**:
```
Problem: "Edge Function times out after 30 seconds"
└─ Solution 1: "Optimize function code to run faster" (85%)
└─ Solution 2: "Use background job for long operations" (90%)
└─ Common pitfall: "Default timeout is 30s on free tier, 150s on pro"
```

### 3. Migration Guides
Extract breaking changes and upgrade issues:
- Version-specific errors
- Deprecated feature warnings
- Migration steps

### 4. FAQ Sections
FAQ = Common issues:
- Extract question as query
- Answer as solution
- Estimate frequency as HIGH

## Output Format

Create SQL INSERT statements in this exact format:

```sql
-- Add official documentation solutions batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, pattern_id
) VALUES (
    'Anthropic API error 529: Overloaded',
    'ai-api',
    'HIGH',
    '[
        {"solution": "Retry request with exponential backoff starting at 1 second", "percentage": 90, "note": "Official recommended approach"},
        {"solution": "Implement retry logic with max 5 attempts", "percentage": 85, "command": "Retry-After header indicates wait time"},
        {"solution": "Switch to batching multiple requests if possible", "percentage": 75, "note": "Reduces total request count"}
    ]'::jsonb,
    'Valid Anthropic API key, Request that previously succeeded',
    'Request returns 200 status code, Response contains expected data',
    'Do not retry immediately - always use exponential backoff. Check Retry-After header.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://docs.anthropic.com/claude/reference/errors-and-rate-limits'
),
(
    'Supabase Edge Function error: Missing environment variable',
    'supabase',
    'HIGH',
    '[
        {"solution": "Set secrets via CLI: supabase secrets set MY_SECRET=value", "percentage": 95, "note": "Secrets persist across deployments"},
        {"solution": "Add to .env.local for local testing: echo MY_SECRET=value >> .env.local", "percentage": 90, "note": "Local development only"},
        {"solution": "Verify secret exists: supabase secrets list", "percentage": 85, "command": "supabase secrets list"}
    ]'::jsonb,
    'Supabase CLI authenticated, Project created, Function deployed',
    'Deno.env.get(\'MY_SECRET\') returns value, Function executes without error',
    'Secrets must be set before deployment. Local .env not used in production. Use supabase secrets, not environment variables in dashboard.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/functions/secrets'
);
```

## Quality Standards

### ✅ Extract if:
- Appears in official documentation
- Has clear reproduction steps
- Solution is actionable
- Error is specific (not "something went wrong")

### ❌ Skip if:
- Vague problem description
- No clear solution provided
- User-specific issue (not general)
- Duplicate of existing entry

## Batching Strategy

Create migrations in batches of 10-15 entries:
- `20251124210500_add_anthropic_docs_batch1.sql`
- `20251124211000_add_openai_docs_batch1.sql`
- `20251124211500_add_supabase_docs_batch1.sql`

## Example Workflow

1. **Start with**: Anthropic API Errors Reference
2. **Extract**: All documented error codes (400, 401, 429, 500, 529)
3. **For each error**:
   - Read problem description
   - Extract all solutions listed
   - Note prerequisites from "Requirements" section
   - Capture warnings/pitfalls from callout boxes
   - Record doc URL
4. **Format**: As SQL INSERT statement
5. **Group**: 10-15 entries per migration file
6. **Name**: File with timestamp and source

## Pattern Matching

If error matches existing pattern, add `pattern_id`:

**Existing Patterns**:
1. `PATH_INHERITANCE` - Command not found (npx, node, python)
2. `STREAMING_BUFFER_CONFLICT` - Middleware blocks streaming
3. `SANDBOX_LOCALHOST_BLOCK` - Security restrictions on localhost
4. `ENV_VAR_CHAIN_DEPENDENCY` - Multiple env vars required
5. `VERSION_REGRESSION` - Fixed in later version
6. `NULL_FEATURE_DETECTION` - Null vs falsy detection

**When to link pattern**:
```sql
pattern_id = (SELECT id FROM patterns WHERE pattern_name = 'PATH_INHERITANCE')
```

## Success Metrics

Track your progress:
- **Entries added**: Count per documentation source
- **Coverage**: % of error codes documented
- **Quality**: Solutions have clear steps + commands

## Final Notes

- **Priority**: Error reference pages > Troubleshooting guides > General docs
- **Clarity**: Use exact error messages from docs
- **Commands**: Include exact commands when docs provide them
- **URLs**: Link to specific doc sections, not just homepage
- **Verification**: Date is NOW() since you're extracting from current docs

## Your First Task

Start with **Anthropic Claude API Errors** documentation. Extract all documented error codes (400, 401, 403, 429, 500, 529) and create your first migration file with 10-15 entries.

Good luck! The knowledge base depends on your thorough extraction. 🎯
