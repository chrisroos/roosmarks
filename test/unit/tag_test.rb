require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "should be valid when built from the factory" do
    assert build(:tag).valid?
  end

  test "should be invalid without a name" do
    tag = build(:tag, name: nil)
    refute tag.valid?
  end

  test "should allow name to be mass assigned" do
    tag = Tag.new(name: 'my-name')
    assert_equal 'my-name', tag.name
  end

  test "should allow description to be mass assigned" do
    tag = Tag.new(description: 'my-description')
    assert_equal 'my-description', tag.description
  end

  test "should not allow created_at to be mass assigned" do
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) { Tag.new(created_at: Time.now) }
  end

  test "should not allow updated_at to be mass assigned" do
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) { Tag.new(updated_at: Time.now) }
  end
end
