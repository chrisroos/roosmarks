require 'test_helper'

class HomepageTest < ActionDispatch::IntegrationTest
  test 'GET / redirects to /bookmarks' do
    get '/'
    assert_redirected_to '/bookmarks'
  end
end
