require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "should follow and unfollow a user" do
    andi = users(:andi)
    ruben  = users(:ruben)
    assert_not andi.following?(ruben)
    andi.follow(ruben)
    assert andi.following?(ruben)
    assert ruben.followers.include?(andi)
    andi.unfollow(ruben)
    assert_not andi.following?(ruben)
  end
end
