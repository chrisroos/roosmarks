require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "should convert the markdown input text to html" do
    assert_equal "<p>markdown-input</p>\n", markdown_to_html('markdown-input')
  end

  test "should convert raw URLs to links" do
    assert_select_in_html markdown_to_html('http://example.com'), "a[href='http://example.com']"
  end

  test "should mark the generated html as html_safe" do
    assert markdown_to_html('').html_safe?
  end

  test "should return an empty string if no text is supplied" do
    assert_equal '', markdown_to_html(nil)
  end
end