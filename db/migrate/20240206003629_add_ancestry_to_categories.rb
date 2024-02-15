class AddAncestryToCategories < ActiveRecord::Migration[7.1]
  def change
    change_table(:categories) do |t|
      t.string "ancestry", collation: "C", null: true
      t.index "ancestry"
    end
  end
end
