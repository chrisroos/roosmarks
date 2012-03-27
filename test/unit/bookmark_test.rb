require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  test "should be invalid without a URL" do
    bookmark = Bookmark.new(url: nil)
    refute bookmark.valid?
  end

  test "should be invalid without a title" do
    bookmark = Bookmark.new(title: nil)
    refute bookmark.valid?
  end
end
