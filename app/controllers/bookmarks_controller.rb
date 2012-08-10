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
    tag_names = params[:bookmark].delete(:tag_names) || ''
    tag_names = tag_names.split(' ')
    tags = tag_names.collect do |tag_name|
      Tag.find_or_create_by_name(tag_name)
    end
    @bookmark = Bookmark.new(params[:bookmark].merge(tags: tags, tag_names: tag_names.join(' ')))
    if @bookmark.save
      redirect_to bookmarks_path
    else
      render :new
    end
  end
end