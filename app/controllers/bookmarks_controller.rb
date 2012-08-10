class BookmarksController < ApplicationController
  before_filter :authenticate, only: [:new, :create]

  def index
    @bookmarks = Bookmark.order('created_at DESC')
    respond_to do |format|
      format.html
      format.atom
    end
  end

  def new
    @bookmark = Bookmark.new(url: params[:url], title: params[:title])
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    if @bookmark.save
      redirect_to bookmarks_path
    else
      render :new
    end
  end
end