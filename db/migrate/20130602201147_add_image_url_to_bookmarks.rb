class AddImageUrlToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :image_url, :string
  end
end