require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  test 'should display all bookmarks' do
    Bookmark.create!(url: "http://example.com", title: "Example.com")

    get :index

    assert_select '#bookmarks' do
      assert_select '.bookmark .url', text: "http://example.com"
      assert_select '.bookmark .title', text: "Example.com"
    end
  end
end