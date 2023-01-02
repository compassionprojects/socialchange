class AddIndexesToStories < ActiveRecord::Migration[7.0]
  def up
    enable_extension "pg_trgm"
    execute "CREATE INDEX IF NOT EXISTS index_stories_on_title_desc_out_src_en ON stories USING gin((title->>'en') gin_trgm_ops, (description->>'en') gin_trgm_ops, (outcomes->>'en') gin_trgm_ops, (source->>'en') gin_trgm_ops);"
    execute "CREATE INDEX IF NOT EXISTS index_stories_on_title_desc_out_src_nl ON stories USING gin((title->>'nl') gin_trgm_ops, (description->>'nl') gin_trgm_ops, (outcomes->>'nl') gin_trgm_ops, (source->>'nl') gin_trgm_ops);"
  end

  def down
    execute "DROP INDEX IF EXISTS index_stories_on_title_desc_out_src_nl"
    execute "DROP INDEX IF EXISTS index_stories_on_title_desc_out_src_en"
    disable_extension "pg_trgm"
  end
end
