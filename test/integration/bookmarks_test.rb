require 'test_helper'

class BookmarksTest < ActionDispatch::IntegrationTest
  test "creating a new bookmark" do
    given_a_user_bookmarks url: "http://example.com", title: "Example.com"
    assert_bookmarked url: "http://example.com", title: "Example.com"
  end

  private

  def given_a_user_bookmarks(attributes)
    visit "/"
    click_link "New bookmark"
    fill_in "Url", with: attributes[:url]
    fill_in "Title", with: attributes[:title]
    click_button "Create bookmark"
  end

  def assert_bookmarked(attributes)
    assert page.has_css?('#bookmarks .bookmark .url', text: attributes[:url])
    assert page.has_css?('#bookmarks .bookmark .title', text: attributes[:title])
  end
end