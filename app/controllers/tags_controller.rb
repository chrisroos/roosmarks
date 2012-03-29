class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @bookmarks = @tag.bookmarks
  end
end