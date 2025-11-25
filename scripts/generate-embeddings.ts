#!/usr/bin/env node
/**
 * Generate OpenAI embeddings for all knowledge entries
 * Usage: OPENAI_API_KEY=sk-xxx node generate-embeddings.ts
 */

import { createClient } from '@supabase/supabase-js';
import OpenAI from 'openai';

const SUPABASE_URL = process.env.SUPABASE_URL || 'https://ksethrexopllfhyrxlrb.supabase.co';
const SUPABASE_SERVICE_KEY = process.env.SUPABASE_SERVICE_KEY;
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;

if (!SUPABASE_SERVICE_KEY) {
  console.error('❌ SUPABASE_SERVICE_KEY required');
  process.exit(1);
}

if (!OPENAI_API_KEY) {
  console.error('❌ OPENAI_API_KEY required');
  console.error('Get one at: https://platform.openai.com/api-keys');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_KEY);
const openai = new OpenAI({ apiKey: OPENAI_API_KEY });

interface KnowledgeEntry {
  id: number;
  query: string;
  category: string;
  common_pitfalls: string | null;
}

async function generateEmbedding(text: string): Promise<number[]> {
  const response = await openai.embeddings.create({
    model: 'text-embedding-3-small',
    input: text,
    encoding_format: 'float',
  });
  return response.data[0].embedding;
}

async function main() {
  console.log('🔍 Fetching entries without embeddings...');

  const { data: entries, error } = await supabase
    .from('knowledge_entries')
    .select('id, query, category, common_pitfalls')
    .is('embedding', null);

  if (error) {
    console.error('❌ Failed to fetch entries:', error);
    process.exit(1);
  }

  console.log(`📊 Found ${entries.length} entries to process`);

  let processed = 0;
  let failed = 0;
  const batchSize = 10;

  for (let i = 0; i < entries.length; i += batchSize) {
    const batch = entries.slice(i, i + batchSize);

    console.log(`\n📦 Processing batch ${Math.floor(i / batchSize) + 1}/${Math.ceil(entries.length / batchSize)}`);

    await Promise.all(
      batch.map(async (entry: KnowledgeEntry) => {
        try {
          // Combine query, category, and pitfalls for rich semantic context
          const textToEmbed = [
            entry.query,
            `Category: ${entry.category}`,
            entry.common_pitfalls ? `Pitfalls: ${entry.common_pitfalls}` : '',
          ]
            .filter(Boolean)
            .join('\n');

          const embedding = await generateEmbedding(textToEmbed);

          const { error: updateError } = await supabase
            .from('knowledge_entries')
            .update({
              embedding,
              embedding_generated_at: new Date().toISOString(),
            })
            .eq('id', entry.id);

          if (updateError) {
            console.error(`  ❌ Failed to update entry ${entry.id}:`, updateError.message);
            failed++;
          } else {
            processed++;
            console.log(`  ✅ Entry ${entry.id}: ${entry.query.substring(0, 60)}...`);
          }
        } catch (err) {
          console.error(`  ❌ Failed to process entry ${entry.id}:`, err instanceof Error ? err.message : err);
          failed++;
        }
      })
    );

    // Rate limiting: wait 1 second between batches
    if (i + batchSize < entries.length) {
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
  }

  console.log(`\n✅ Complete: ${processed} processed, ${failed} failed`);
  console.log(`💰 Estimated cost: $${((entries.length * 0.00013) / 1000).toFixed(4)}`);
}

main().catch(console.error);
