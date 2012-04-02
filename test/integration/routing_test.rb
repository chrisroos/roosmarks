require 'test_helper'

class BookmarkRoutingTest < ActionDispatch::IntegrationTest
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

class TagRoutingTest < ActionDispatch::IntegrationTest
  test 'GET /tags/<id> maps to tags#show' do
    assert_routing({path: 'tags/1', method: :get}, {controller: 'tags', action: 'show', id: '1'})
  end

  test 'GET /tags/<id>/edit maps to tags#edit' do
    assert_routing({path: 'tags/1/edit', method: :get}, {controller: 'tags', action: 'edit', id: '1'})
  end

  test 'PUT /tags/<id> maps to tags#update' do
    assert_routing({path: 'tags/1', method: :put}, {controller: 'tags', action: 'update', id: '1'})
  end
end