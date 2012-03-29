require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  test "should be valid when built from the factory" do
    assert build(:tag).valid?
  end

  test "should be invalid without a name" do
    tag = build(:tag, name: nil)
    refute tag.valid?
  end
end
