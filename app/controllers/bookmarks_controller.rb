class BookmarksController < ApplicationController
  before_filter :authenticate, only: [:new, :create]

  def index
    @bookmarks = Bookmark.all
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
    Bookmark.create! params[:bookmark].merge(tags: tags)
    redirect_to bookmarks_path
  end
end