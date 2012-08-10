ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryGirl::Syntax::Methods

  def login!
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("#{USERNAME}:#{PASSWORD}")
  end
end

class ActionView::TestCase
  def assert_select_in_html(text, *args, &block)
    assert_select HTML::Document.new(text).root, *args, &block
  end
end

class ActionController::TestCase
  def assert_bookmark_atom_feed_entry(bookmark)
    assert_select 'feed entry' do
      assert_select 'published', text: bookmark.created_at.xmlschema
      assert_select 'updated', text: bookmark.updated_at.xmlschema
      assert_select 'link[href=?]', bookmark.url
      assert_select 'title', text: bookmark.title
      assert_select 'content', text: /#{bookmark.comments}/
    end
  end
end