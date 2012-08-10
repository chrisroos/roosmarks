class AddTagNamesToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :tag_names, :string
  end
end