class AddUniqueIndexToBookmarkUrls < ActiveRecord::Migration
  def change
    add_index :bookmarks, :url, unique: true
  end
end