class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    Bookmark.create! params[:bookmark]
    redirect_to bookmarks_path
  end
end