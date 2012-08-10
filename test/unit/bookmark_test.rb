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

  test "should be invalid if the url has already been bookmarked" do
    bookmark_1 = create(:bookmark)
    bookmark_2 = build(:bookmark, url: bookmark_1.url)
    refute bookmark_2.save
  end

  test "should allow url to be mass assigned" do
    bookmark = Bookmark.new(url: 'http://example.com')
    assert_equal 'http://example.com', bookmark.url
  end

  test "should allow title to be mass assigned" do
    bookmark = Bookmark.new(title: 'my-title')
    assert_equal 'my-title', bookmark.title
  end

  test "should allow comments to be mass assigned" do
    bookmark = Bookmark.new(comments: 'my-comments')
    assert_equal 'my-comments', bookmark.comments
  end

  test "should allow tag_names to be mass assigned" do
    bookmark = Bookmark.new(tag_names: 'tag-1 tag-2')
    assert_equal 'tag-1 tag-2', bookmark.tag_names
  end

  test "should not allow tags to be mass assigned" do
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) { Bookmark.new(tags: []) }
  end

  test "should not allow created_at to be mass assigned" do
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) { Bookmark.new(created_at: Time.now) }
  end

  test "should not allow updated_at to be mass assigned" do
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) { Bookmark.new(updated_at: Time.now) }
  end

  test "should return the domain of the bookmark URL" do
    bookmark = build(:bookmark, url: "http://www.example.com/foo/bar/baz")
    assert_equal 'www.example.com', bookmark.domain
  end

  test "should split the list of tags and create tag objects" do
    bookmark = create(:bookmark, tag_names: 'tag-1 tag-2')
    bookmark.reload
    assert_equal [Tag.find_by_name!('tag-1'), Tag.find_by_name!('tag-2')], bookmark.tags
  end

  test "should not create duplicate tags" do
    bookmark = create(:bookmark, tag_names: 'tag-1 tag-1')
    assert_equal [Tag.find_by_name!('tag-1')], bookmark.tags
  end
end
