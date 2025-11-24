#!/usr/bin/env node
/**
 * Migrate SQLite data to Supabase
 * Reads from /tmp/claude-code-kb.db and inserts into Supabase
 */

import { createClient } from '@supabase/supabase-js'
import sqlite3 from 'sqlite3'
import { promisify } from 'util'

// Get Supabase credentials from env
const SUPABASE_URL = process.env.SUPABASE_URL
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY

if (!SUPABASE_URL || !SUPABASE_SERVICE_KEY) {
  console.error('❌ Missing environment variables:')
  console.error('   SUPABASE_URL - Your Supabase project URL')
  console.error('   SUPABASE_SERVICE_KEY - Your service role key (from Settings → API)')
  process.exit(1)
}

// Initialize Supabase client
const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY)

// SQLite database path
const SQLITE_DB = '/tmp/claude-code-kb.db'

async function migrate() {
  console.log('🔄 Starting migration from SQLite to Supabase...\n')

  // Test Supabase connection
  const { error: testError } = await supabase.from('knowledge_entries').select('count').limit(1)
  if (testError) {
    console.error('❌ Failed to connect to Supabase:', testError.message)
    console.error('   Make sure you ran the schema.sql in Supabase SQL Editor first!')
    process.exit(1)
  }
  console.log('✅ Connected to Supabase\n')

  // Open SQLite database
  const db = new sqlite3.Database(SQLITE_DB)
  const dbAll = promisify(db.all.bind(db))

  try {
    // Get all knowledge entries from SQLite
    const entries = await dbAll('SELECT * FROM knowledge_entries')
    console.log(`📦 Found ${entries.length} knowledge entries in SQLite\n`)

    let migrated = 0
    let skipped = 0

    for (const entry of entries) {
      // Parse JSON solutions
      let solutions
      try {
        solutions = typeof entry.solutions === 'string'
          ? JSON.parse(entry.solutions)
          : entry.solutions
      } catch (e) {
        console.error(`⚠️  Skipping entry ${entry.id}: Invalid JSON in solutions`)
        skipped++
        continue
      }

      // Check if entry already exists
      const { data: existing } = await supabase
        .from('knowledge_entries')
        .select('id')
        .eq('query', entry.query)
        .single()

      if (existing) {
        console.log(`⏭️  Skipping: "${entry.query}" (already exists)`)
        skipped++
        continue
      }

      // Use the add_knowledge_entry function
      const prerequisites = entry.prerequisites
        ? entry.prerequisites.split(',').map(p => p.trim())
        : []

      const success_indicators = entry.success_indicators
        ? entry.success_indicators.split(',').map(s => s.trim())
        : []

      const { data, error } = await supabase.rpc('add_knowledge_entry', {
        p_query: entry.query,
        p_category: entry.category,
        p_solutions: solutions,
        p_prerequisites: prerequisites,
        p_success_indicators: success_indicators,
        p_common_pitfalls: entry.common_pitfalls || '',
        p_hit_frequency: entry.hit_frequency || 'MEDIUM',
        p_success_rate: entry.success_rate
      })

      if (error) {
        console.error(`❌ Failed to migrate: "${entry.query}"`)
        console.error(`   Error: ${error.message}`)
        skipped++
      } else {
        console.log(`✅ Migrated: "${entry.query}"`)
        migrated++
      }
    }

    console.log(`\n🎉 Migration complete!`)
    console.log(`   ✅ Migrated: ${migrated} entries`)
    if (skipped > 0) {
      console.log(`   ⏭️  Skipped: ${skipped} entries`)
    }

  } catch (error) {
    console.error('❌ Migration failed:', error.message)
    process.exit(1)
  } finally {
    db.close()
  }
}

migrate()
