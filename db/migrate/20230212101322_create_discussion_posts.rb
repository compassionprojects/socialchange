class CreateDiscussionPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :discussion_posts do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true
      t.references :updater, null: false, foreign_key: { to_table: :users }, index: true
      t.references :discussion_topic, null: false, foreign_key: true, index: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
