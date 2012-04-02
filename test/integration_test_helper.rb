require "test_helper"
require 'capybara/rails'

# Transactional fixtures do not work with Selenium tests, because Capybara
# uses a separate server thread, which the transactions would be hidden
# from. We hence use DatabaseCleaner to truncate our test database.
DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  teardown do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end

  def visit_tag_page(tag_name)
    visit "/"
    click_link tag_name
  end

  def given_a_user_bookmarks(attributes)
    visit "/"
    click_link "New bookmark"
    fill_in "Url", with: attributes[:url]
    fill_in "Title", with: attributes[:title]
    fill_in "Tags", with: attributes[:tags]
    click_button "Create bookmark"
  end

  def when_viewing_the_tag_page(tag_name)
    visit_tag_page(tag_name)
  end

  def when_describing_a_tag(options)
    tag = Tag.find_by_name!(options[:tag])
    visit tag_path(tag)
    click_link "Edit"
    fill_in "Description", with: options[:description]
    click_button "Save"
  end

  def assert_bookmark_visible(attributes)
    assert page.has_css?('#bookmarks .bookmark .url', text: attributes[:url])
    assert page.has_css?('#bookmarks .bookmark .title', text: attributes[:title])
    (attributes[:tags] || '').split(' ').each do |tag|
      assert page.has_css?('#bookmarks .bookmark .tags', text: tag)
    end
  end

  def assert_tag_attributes(attributes)
    visit_tag_page(attributes[:tag])
    assert page.has_css? ".description", text: attributes[:description]
  end
end