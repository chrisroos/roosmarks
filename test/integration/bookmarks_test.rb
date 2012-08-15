require 'integration_test_helper'

class BookmarksTest < ActionDispatch::IntegrationTest
  test "creating a new bookmark" do
    given_a_user_bookmarks url: "http://example.com", title: "Example.com"
    assert_bookmark_visible url: "http://example.com", title: "Example.com"
  end

  test "creating a new bookmark with some tags" do
    given_a_user_bookmarks url: "http://example.com", title: "Example.com", tags: "tag-1 tag-2"
    assert_bookmark_visible url: "http://example.com", title: "Example.com", tags: "tag-1 tag-2"
  end

  test "editing a bookmark" do
    given_a_user_bookmarks url: "http://example.com", title: "original-title", tags: "original-tag", comments: "original-comments"
    and_a_user_edits_the_bookmark url: "http://example.com", title: "new-title", tags: "new-tag", comments: "new-comments"
    assert_bookmark_visible url: "http://example.com", title: "new-title", tags: "new-tag", comments: "new-comments"
  end
end