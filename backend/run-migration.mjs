import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  'https://ksethrexopllfhyrxlrb.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZXRocmV4b3BsbGZoeXJ4bHJiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2Mzc0NTg4OSwiZXhwIjoyMDc5MzIxODg5fQ.sTbWJmQkfPlBZqA6L89LdYUdyNlr8fq8aRNrKpwx0NY'
);

console.log('🔄 Running migration...\n');

const migration = `
ALTER TABLE knowledge_entries
ADD COLUMN IF NOT EXISTS thumbs_up INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS thumbs_down INTEGER DEFAULT 0;

CREATE INDEX IF NOT EXISTS idx_thumbs_rating ON knowledge_entries((thumbs_up - thumbs_down) DESC);
`;

const { data, error } = await supabase.rpc('exec', { sql: migration });

if (error) {
  console.error('❌ Migration failed:', error.message);
  process.exit(1);
}

console.log('✅ Migration complete!');
console.log('   - Added thumbs_up column');
console.log('   - Added thumbs_down column');
console.log('   - Added idx_thumbs_rating index');
