# Database Migrations

## Add Thumbs Up/Down Columns (Pending)

**Migration**: `add_thumbs_feedback.sql`

**Status**: Ready to apply

**Instructions**:
1. Go to Supabase Dashboard: https://supabase.com/dashboard/project/ksethrexopllfhyrxlrb
2. Click "SQL Editor" in the left sidebar
3. Click "New Query"
4. Copy and paste the contents of `add_thumbs_feedback.sql`
5. Click "Run"

**What it does**:
- Adds `thumbs_up INTEGER DEFAULT 0` column to `knowledge_entries`
- Adds `thumbs_down INTEGER DEFAULT 0` column to `knowledge_entries`
- Creates index `idx_thumbs_rating` for sorting by community rating

**Verification**:
```sql
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'knowledge_entries'
AND column_name IN ('thumbs_up', 'thumbs_down');
```

Should return 2 rows showing the new columns.
