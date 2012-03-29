require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  test 'should display all bookmarks' do
    create(:bookmark, url: "http://example.com", title: "Example.com")

    get :index

    assert_select '#bookmarks' do
      assert_select '.bookmark .url', text: "http://example.com"
      assert_select '.bookmark .title', text: "Example.com"
    end
  end

  test 'should display all fields used to add a new bookmark' do
    get :new

    assert_select 'form[action=/bookmarks][method=post]' do
      assert_select "input[type=text][name='bookmark[url]']"
      assert_select "input[type=text][name='bookmark[title]']"
      assert_select "textarea[name='bookmark[comments]']"
      assert_select 'input[type=submit]'
    end
  end

  test 'should allow a bookmark to be added' do
    post :create, bookmark: {url: 'http://example.com', title: 'Example.com'}

    assert_equal 'http://example.com', Bookmark.last.url
    assert_equal 'Example.com', Bookmark.last.title
  end

  test 'should redirect to the list of bookmarks after creation' do
    post :create, bookmark: {url: 'http://example.com', title: 'Example.com'}

    assert_redirected_to bookmarks_path
  end
end