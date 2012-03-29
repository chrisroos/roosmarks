require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  test "should be valid when build from the factory" do
    assert build(:bookmark).valid?
  end

  test "should be invalid without a URL" do
    bookmark = build(:bookmark, url: nil)
    refute bookmark.valid?
  end

  test "should be invalid without a title" do
    bookmark = build(:bookmark, title: nil)
    refute bookmark.valid?
  end
end
