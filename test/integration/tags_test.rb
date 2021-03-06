require 'integration_test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  test "Viewing all bookmarks for a given tag" do
    given_a_user_bookmarks url: "http://foo.com", title: "foo.com", tags: "tag-1"
    given_a_user_bookmarks url: "http://bar.com", title: "bar.com", tags: "tag-1"

    when_viewing_the_tag_page "tag-1"

    assert_bookmark_visible url: "http://foo.com", title: "foo.com"
    assert_bookmark_visible url: "http://bar.com", title: "bar.com"
  end

  test "Adding a description to a tag" do
    given_a_user_bookmarks url: "http://foo.com", title: "foo.com", tags: "tag-1"

    when_describing_a_tag tag: "tag-1", description: "tag-description"

    assert_tag_attributes tag: "tag-1", description: "tag-description"
  end
end