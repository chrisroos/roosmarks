require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest
  test 'GET /bookmarks maps to bookmarks#index' do
    assert_routing({path: 'bookmarks', method: :get}, {controller: 'bookmarks', action: 'index'})
  end

  test 'POST /bookmarks maps to bookmarks#create' do
    assert_routing({path: 'bookmarks', method: :post}, {controller: 'bookmarks', action: 'create'})
  end

  test 'GET /bookmarks/new maps to bookmarks#new' do
    assert_routing({path: 'bookmarks/new', method: :get}, {controller: 'bookmarks', action: 'new'})
  end
end
