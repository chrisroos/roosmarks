require "test_helper"

class TagsControllerTest < ActionController::TestCase
  test "should display all bookmarks for the tag" do
    tag = create(:tag)
    bookmark_1 = create(:bookmark, tags: [tag], title: 'bookmark-1')
    bookmark_2 = create(:bookmark, tags: [tag], title: 'bookmark-2')
    bookmark_3 = create(:bookmark, title: 'bookmark-without-tags')

    get :show, id: tag

    assert_select '#bookmarks' do
      assert_select '.bookmark .title', text: 'bookmark-1'
      assert_select '.bookmark .title', text: 'bookmark-2'
      assert_select '.bookmark .title', text: 'bookmark-without-tags', count: 0
    end
  end

  test "should update the tag with the given description" do
    tag = create(:tag, description: nil)

    put :update, id: tag, tag: {description: "tag-description"}

    assert_equal "tag-description", tag.reload.description
  end

  test "should redirect to the tag page after updating" do
    tag = create(:tag)

    put :update, id: tag

    assert_redirected_to tag_path(tag)
  end
end