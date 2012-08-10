require "test_helper"

class TagsControllerTest < ActionController::TestCase
  test 'should set the #show page title' do
    tag = create(:tag, name: 'my-tag')
    create(:bookmark, tags: [tag])

    get :show, id: tag

    assert_select 'title', text: 'Bookmarks tagged with my-tag | Roosmarks'
  end

  test "should display all bookmarks for the tag" do
    bookmark_1 = create(:bookmark, tag_names: 'tag-1', title: 'bookmark-1')
    bookmark_2 = create(:bookmark, tag_names: 'tag-1', title: 'bookmark-2')
    bookmark_3 = create(:bookmark, title: 'bookmark-without-tags')
    tag = Tag.find_by_name! 'tag-1'

    get :show, id: tag

    assert_select '#bookmarks' do
      assert_select '.bookmark .title', text: 'bookmark-1'
      assert_select '.bookmark .title', text: 'bookmark-2'
      assert_select '.bookmark .title', text: 'bookmark-without-tags', count: 0
    end
  end

  test 'should display bookmarks in reverse chronological order' do
    create(:bookmark, tag_names: 'tag-1', title: 'older-bookmark', created_at: 1.month.ago)
    create(:bookmark, tag_names: 'tag-1', title: 'newer-bookmark', created_at: 1.day.ago)
    tag = Tag.find_by_name! 'tag-1'

    get :show, id: tag

    assert_select '#bookmarks .bookmark:first-child .title', text: 'newer-bookmark'
    assert_select '#bookmarks .bookmark:last-child .title', text: 'older-bookmark'
  end

  test 'should automatically link to URLs in the description' do
    tag = create(:tag, description: 'http://example.com')

    get :show, id: tag

    assert_select ".description a[href=http://example.com]"
  end

  test 'should set the #edit page title' do
    login!
    tag = create(:tag, name: 'my-tag')

    get :edit, id: tag

    assert_select 'title', text: 'Edit my-tag | Roosmarks'
  end

  test 'should prevent unauthenticated users from accessing the edit tag form' do
    tag = create(:tag)

    get :edit, id: tag

    assert_response :unauthorized
  end

  test 'should prevent unauthenticated users from updating a tag' do
    tag = create(:tag)

    post :update, id: tag, tag: {}

    assert_response :unauthorized
  end

  test "should update the tag with the given description" do
    tag = create(:tag, description: nil)

    login!
    put :update, id: tag, tag: {description: "tag-description"}

    assert_equal "tag-description", tag.reload.description
  end

  test "should redirect to the tag page after updating" do
    tag = create(:tag)

    login!
    put :update, id: tag

    assert_redirected_to tag_path(tag)
  end
end