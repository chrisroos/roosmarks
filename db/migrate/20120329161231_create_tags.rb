class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, force: true do |t|
      t.string :name
      t.timestamps
    end
    add_index :tags, :name, unique: true

    create_table :bookmarks_tags, force: true, id: false do |t|
      t.integer :bookmark_id
      t.integer :tag_id
    end
    add_index :bookmarks_tags, [:bookmark_id, :tag_id], unique: true
  end
end