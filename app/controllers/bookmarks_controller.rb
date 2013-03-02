class BookmarksController < ApplicationController
  before_filter :authenticate, only: [:new, :create, :edit, :update]

  def index
    @bookmarks = Bookmark.order('created_at DESC')
    respond_to do |format|
      format.html
      format.atom
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    if bookmark = Bookmark.find_by_url(params[:url])
      redirect_to edit_bookmark_path(bookmark)
    else
      @bookmark = Bookmark.new(url: params[:url], title: params[:title])
    end
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    if @bookmark.save
      redirect_to bookmarks_path
    else
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    bookmark_params = params[:bookmark]
    bookmark_params.delete(:url)
    if @bookmark.update_attributes(bookmark_params)
      redirect_to bookmarks_path
    else
      render :edit
    end
  end
end