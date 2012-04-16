class TagsController < ApplicationController
  before_filter :authenticate, only: [:edit, :update]

  def show
    @tag = Tag.find(params[:id])
    @bookmarks = @tag.bookmarks
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    tag = Tag.find(params[:id])
    tag.update_attributes(params[:tag])
    redirect_to tag_path(tag)
  end
end