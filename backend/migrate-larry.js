#!/usr/bin/env node
// Migrate Larry solutions to clauderepo

import { createClient } from '@supabase/supabase-js';
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

const SUPABASE_URL = 'https://ksethrexopllfhyrxlrb.supabase.co';
const SUPABASE_SERVICE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZXRocmV4b3BsbGZoeXJ4bHJiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2Mzc0NTg4OSwiZXhwIjoyMDc5MzIxODg5fQ.WLTora-ocodgAzYop0H_fAR36Pjxvov4DhBbaIrps1g';

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);

async function exportLarry() {
  console.log('📦 Exporting Larry patterns...');

  const { stdout } = await execAsync(
    `turso db shell larry "SELECT json_object('pattern_id', pattern_id, 'symptom', symptom, 'diagnosis', diagnosis, 'solution', solution, 'code_fix', code_fix, 'framework', framework, 'confidence', confidence) FROM issue_patterns;"`
  );

  // Parse JSON objects from output
  const lines = stdout.split('\n').filter(line => line.trim().startsWith('{'));
  const patterns = lines.map(line => JSON.parse(line));

  console.log(`✅ Found ${patterns.length} Larry patterns`);
  return patterns;
}

function transformToClaudeRepo(larryPattern) {
  // Map Larry confidence to frequency
  const confidenceToFrequency = {
    'verified': 'HIGH',
    'production': 'HIGH',
    'high': 'MEDIUM',
    'medium': 'MEDIUM',
    'low': 'LOW'
  };

  // Extract category from framework or symptom
  const category = larryPattern.framework ||
                   (larryPattern.symptom.toLowerCase().includes('mcp') ? 'mcp-troubleshooting' :
                    larryPattern.symptom.toLowerCase().includes('playwright') ? 'web-automation' :
                    larryPattern.symptom.toLowerCase().includes('supabase') ? 'database' :
                    larryPattern.symptom.toLowerCase().includes('svelte') ? 'svelte' :
                    'general');

  // Build solutions array
  const solutions = [
    {
      solution: larryPattern.solution,
      percentage: larryPattern.confidence === 'verified' ? 95 :
                  larryPattern.confidence === 'production' ? 90 :
                  larryPattern.confidence === 'high' ? 85 : 75,
      command: larryPattern.code_fix || undefined,
      note: larryPattern.diagnosis
    }
  ];

  return {
    query: larryPattern.symptom,
    category: category,
    hit_frequency: confidenceToFrequency[larryPattern.confidence] || 'MEDIUM',
    solutions: solutions,
    common_pitfalls: larryPattern.diagnosis,
    prerequisites: ['Review error logs', 'Check configuration'],
    success_indicators: ['Error resolved', 'Feature works as expected'],
    success_rate: solutions[0].percentage / 100.0,
    claude_version: 'sonnet-4',
    last_verified: new Date().toISOString()
  };
}

async function insertToClaudeRepo(entry) {
  // Use REST API with service role key (bypasses RLS)
  try {
    const response = await fetch(`${SUPABASE_URL}/rest/v1/knowledge_entries`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${SUPABASE_SERVICE_KEY}`,
        'apikey': SUPABASE_SERVICE_KEY,
        'Prefer': 'return=representation,resolution=merge-duplicates'
      },
      body: JSON.stringify({
        query: entry.query,
        category: entry.category,
        hit_frequency: entry.hit_frequency,
        solutions: entry.solutions,
        common_pitfalls: entry.common_pitfalls,
        success_rate: entry.success_rate,
        claude_version: entry.claude_version,
        last_verified: entry.last_verified
      })
    });

    if (!response.ok) {
      const error = await response.json();
      // Check for duplicate key error
      if (error.code === '23505' || error.message?.includes('duplicate')) {
        console.log(`   ⏭️  Skipped (duplicate): ${entry.query.substring(0, 50)}...`);
        return { skipped: true };
      }
      throw new Error(error.message || response.statusText);
    }

    const result = await response.json();
    return { success: true, id: result[0]?.id };
  } catch (err) {
    // If duplicate, skip
    if (err.message && (err.message.includes('duplicate') || err.message.includes('23505'))) {
      console.log(`   ⏭️  Skipped (duplicate): ${entry.query.substring(0, 50)}...`);
      return { skipped: true };
    }
    throw err;
  }
}

async function main() {
  console.log('🚀 Larry → clauderepo Migration\n');

  try {
    // Export from Larry
    const larryPatterns = await exportLarry();

    // Transform and insert
    console.log('\n📝 Inserting into clauderepo...');
    let inserted = 0;
    let skipped = 0;
    let errors = 0;

    for (const pattern of larryPatterns) {
      try {
        const entry = transformToClaudeRepo(pattern);
        const result = await insertToClaudeRepo(entry);

        if (result.skipped) {
          skipped++;
        } else {
          inserted++;
          console.log(`   ✅ Inserted: ${entry.query.substring(0, 60)}...`);
        }
      } catch (err) {
        errors++;
        console.error(`   ❌ Error: ${pattern.symptom.substring(0, 50)}...`);
        console.error(`      ${err.message}`);
      }
    }

    console.log(`\n✅ Migration complete!`);
    console.log(`   Inserted: ${inserted}`);
    console.log(`   Skipped:  ${skipped}`);
    console.log(`   Errors:   ${errors}`);
    console.log(`   Total:    ${larryPatterns.length}`);

  } catch (error) {
    console.error('❌ Migration failed:', error.message);
    process.exit(1);
  }
}

main();
