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
    first(:link, tag_name).click
  end

  def login!
    page.driver.browser.basic_authorize USERNAME, PASSWORD
  end

  def given_a_user_bookmarks(attributes)
    unknown_keys = attributes.keys - [:url, :title, :tags, :comments]
    raise "Unknown keys: #{unknown_keys}" if unknown_keys.any?

    login!
    visit "/"
    click_link "New bookmark"
    fill_in "Url", with: attributes[:url]
    fill_in "Title", with: attributes[:title]
    fill_in "Tags", with: attributes[:tags]
    fill_in "Comments", with: attributes[:comments]
    click_button "Create bookmark"
  end

  def and_a_user_edits_the_bookmark(attributes)
    unknown_keys = attributes.keys - [:url, :title, :tags, :comments]
    raise "Unknown keys: #{unknown_keys}" if unknown_keys.any?

    click_link "Edit the bookmark for #{attributes[:url]}"
    fill_in "Title", with: attributes[:title]
    fill_in "Tags", with: attributes[:tags]
    fill_in "Comments", with: attributes[:comments]
    click_button "Update bookmark"
  end

  def when_viewing_the_tag_page(tag_name)
    visit_tag_page(tag_name)
  end

  def when_describing_a_tag(attributes)
    unknown_keys = attributes.keys - [:tag, :description]
    raise "Unknown keys: #{unknown_keys}" if unknown_keys.any?

    tag = Tag.find_by_name!(attributes[:tag])
    visit tag_path(tag)
    click_link "Edit tag"
    fill_in "Description", with: attributes[:description]
    click_button "Update tag"
  end

  def assert_bookmark_visible(attributes)
    unknown_keys = attributes.keys - [:url, :title, :tags, :comments]
    raise "Unknown keys: #{unknown_keys}" if unknown_keys.any?

    assert page.has_css?("#bookmarks .bookmark a[href='#{attributes[:url]}']"), "expected bookmark to link to '#{attributes[:url]}'"
    assert page.has_css?('#bookmarks .bookmark .title', text: attributes[:title]), "expected bookmark to be titled '#{attributes[:title]}'"
    (attributes[:tags] || '').split(' ').each do |tag|
      assert page.has_css?('#bookmarks .bookmark .tags', text: tag), "expected bookmark to be tagged with '#{attributes[:tag]}'"
    end
    assert page.has_css?('#bookmarks .bookmark .comments', text: attributes[:comments]), "expected bookmark to have comment '#{attributes[:comments]}'"
  end

  def assert_tag_attributes(attributes)
    unknown_keys = attributes.keys - [:tag, :description]
    raise "Unknown keys: #{unknown_keys}" if unknown_keys.any?

    visit_tag_page(attributes[:tag])
    assert page.has_css? ".description", text: attributes[:description]
  end
end