require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest
  test 'GET /bookmarks maps to bookmarks#index' do
    assert_routing({path: 'bookmarks', method: :get}, {controller: 'bookmarks', action: 'index'})
  end
end
