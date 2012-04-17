require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  test 'should display bookmarks in reverse chronological order' do
    create(:bookmark, title: 'older-bookmark', created_at: 1.month.ago)
    create(:bookmark, title: 'newer-bookmark', created_at: 1.day.ago)

    get :index

    assert_select '#bookmarks .bookmark:first-child .title', text: 'newer-bookmark'
    assert_select '#bookmarks .bookmark:last-child .title', text: 'older-bookmark'
  end

  test 'should display the bookmark title' do
    create(:bookmark, title: 'Example.com')

    get :index

    assert_select '.bookmark .title', text: "Example.com"
  end

  test 'should display the bookmark comments' do
    create(:bookmark, comments: 'bookmark-comments')

    get :index

    assert_select '.bookmark .comments', text: "bookmark-comments"
  end

  test 'should link to the bookmarked url' do
    create(:bookmark, url: 'http://example.com')

    get :index

    assert_select "a[href='http://example.com']"
  end

  test 'should link to the tags' do
    tag = create(:tag, name: "tag-1")
    create(:bookmark, tags: [tag])

    get :index

    assert_select '#bookmarks' do
      assert_select "a[href=#{tag_path(tag)}]", text: "tag-1"
    end
  end

  test 'should prevent unauthenticated users from accessing the new bookmarks form' do
    get :new

    assert_response :unauthorized
  end

  test 'should display all fields used to add a new bookmark' do
    login!

    get :new

    assert_select 'form[action=/bookmarks][method=post]' do
      assert_select "input[type=text][name='bookmark[url]']"
      assert_select "input[type=text][name='bookmark[title]']"
      assert_select "input[type=text][name='bookmark[tag_names]']"
      assert_select "textarea[name='bookmark[comments]']"
      assert_select 'input[type=submit]'
    end
  end

  test 'should populate the url and title using the supplied parameters' do
    login!

    get :new, url: 'http://example.com', title: 'example.com'

    assert_select "input[name='bookmark[url]'][value='http://example.com']"
    assert_select "input[name='bookmark[title]'][value='example.com']"
  end

  test 'should prevent unauthenticated users from creating new bookmarks' do
    post :create, bookmark: {}

    assert_response :unauthorized
  end

  test 'should allow a bookmark to be added' do
    login!

    post :create, bookmark: {url: 'http://example.com', title: 'Example.com', tag_names: 'tag-1 tag-2'}

    assert_equal 'http://example.com', Bookmark.last.url
    assert_equal 'Example.com', Bookmark.last.title
    assert_equal ['tag-1', 'tag-2'], Bookmark.last.tags.map(&:name).sort
  end

  test 'should redirect to the list of bookmarks after creation' do
    login!

    post :create, bookmark: {url: 'http://example.com', title: 'Example.com'}

    assert_redirected_to bookmarks_path
  end
end