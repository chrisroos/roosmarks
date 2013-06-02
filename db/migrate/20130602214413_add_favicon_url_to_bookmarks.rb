class AddFaviconUrlToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :favicon_url, :string
  end
end
