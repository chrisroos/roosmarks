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

  test 'should display the domain of the bookmarked page' do
    create(:bookmark, url: 'http://www.example.com/foo/bar/baz')

    get :index

    assert_select '.bookmark .domain', text: 'www.example.com'
  end

  test 'should display the bookmark comments' do
    create(:bookmark, comments: 'bookmark-comments')

    get :index

    assert_select '.bookmark .comments', text: "bookmark-comments"
  end

  test 'should automatically link to URLs in comments' do
    create(:bookmark, comments: 'http://example.com')

    get :index

    assert_select ".bookmark .comments a[href=http://example.com]"
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

  test 'should link to the atom feed' do
    get :index

    assert_select "link[href=#{bookmarks_url(format: 'atom')}][type='application/atom+xml'][rel='alternate']"
  end

  test 'should render atom feed of all bookmarks' do
    oldest_bookmark = create(:bookmark, title: 'bookmark-1', comments: 'comments-about-bookmark-1', created_at: 2.days.ago, updated_at: 2.days.ago)
    newest_bookmark = create(:bookmark, title: 'bookmark-2', comments: 'comments-about-bookmark-2', created_at: 1.day.ago, updated_at: 1.day.ago)

    get :index, format: 'atom'

    assert_select 'feed title', text: 'All bookmarks'
    assert_select 'feed updated', text: newest_bookmark.updated_at.xmlschema
    assert_select 'feed author name', text: USERNAME
    assert_bookmark_atom_feed_entry(newest_bookmark)
    assert_bookmark_atom_feed_entry(oldest_bookmark)
  end

  test 'should use the title as the atom feed entry if the comments are empty' do
    create(:bookmark, title: 'bookmark-1', comments: '')

    get :index, format: 'atom'

    assert_select 'content', text: 'bookmark-1'
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

  test 'should add the required atttribute to the required fields' do
    login!

    get :new

    assert_select 'form[action=/bookmarks][method=post]' do
      assert_select "input[name='bookmark[url]'][required='required']"
      assert_select "input[name='bookmark[title]'][required='required']"
    end
  end

  test 'should add a class to the required control-groups' do
    login!

    get :new

    assert_select 'form[action=/bookmarks][method=post]' do
      assert_select ".required input[name='bookmark[url]']"
      assert_select ".required input[name='bookmark[title]']"
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

  test 'should display errors messages if the bookmark creation failed' do
    login!

    post :create, bookmark: {}

    assert_select '.error #bookmark_url'
    assert_select '.error', text: /Please enter a unique URL/
    assert_select '.error #bookmark_title'
    assert_select '.error', text: /Please enter a title/
  end

  test 'should redirect to the list of bookmarks after creation' do
    login!

    post :create, bookmark: {url: 'http://example.com', title: 'Example.com'}

    assert_redirected_to bookmarks_path
  end
end