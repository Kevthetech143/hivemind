-- Add thumbs up/down columns for user feedback tracking
ALTER TABLE knowledge_entries
ADD COLUMN IF NOT EXISTS thumbs_up INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS thumbs_down INTEGER DEFAULT 0;

-- Create index for sorting by community rating (thumbs_up - thumbs_down)
CREATE INDEX IF NOT EXISTS idx_thumbs_rating ON knowledge_entries((thumbs_up - thumbs_down) DESC);
