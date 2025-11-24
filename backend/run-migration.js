// Run migration to add thumbs_up/thumbs_down columns
import { createClient } from '@supabase/supabase-js';

const SUPABASE_URL = 'https://ksethrexopllfhyrxlrb.supabase.co';
const SERVICE_ROLE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZXRocmV4b3BsbGZoeXJ4bHJiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2Mzc0NTg4OSwiZXhwIjoyMDc5MzIxODg5fQ.sTbWJmQkfPlBZqA6L89LdYUdyNlr8fq8aRNrKpwx0NY';

const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY);

const migration = `
ALTER TABLE knowledge_entries
ADD COLUMN IF NOT EXISTS thumbs_up INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS thumbs_down INTEGER DEFAULT 0;

CREATE INDEX IF NOT EXISTS idx_thumbs_rating ON knowledge_entries((thumbs_up - thumbs_down) DESC);
`;

console.log('Running migration...');

// Use RPC to execute raw SQL
const { data, error } = await supabase.rpc('exec', { sql: migration });

if (error) {
  console.error('Migration failed:', error);
  process.exit(1);
}

console.log('✅ Migration complete!');
console.log('Added columns: thumbs_up, thumbs_down');
console.log('Added index: idx_thumbs_rating');
