class AddIndexesToStoryUpdates < ActiveRecord::Migration[7.0]
  def up
    execute "CREATE INDEX IF NOT EXISTS index_story_updates_on_title_desc_en ON story_updates USING gin((title->>'en') gin_trgm_ops, (description->>'en') gin_trgm_ops);"
    execute "CREATE INDEX IF NOT EXISTS index_story_updates_on_title_desc_nl ON story_updates USING gin((title->>'nl') gin_trgm_ops, (description->>'nl') gin_trgm_ops);"
  end

  def down
    execute "DROP INDEX IF EXISTS index_story_updates_on_title_desc_en"
    execute "DROP INDEX IF EXISTS index_story_updates_on_title_desc_nl"
  end
end
