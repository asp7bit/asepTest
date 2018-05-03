require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
  	user       = users(:andi)
    other_user = users(:john)
    @friendship = Friendship.new(follower_id: user.id, followed_id: other_user.id)
  end

  test "should be valid" do
    assert @friendship.valid?
  end
  
  test "should require a follower_id" do
    @friendship.follower_id = nil
    assert_not @friendship.valid?
  end

  test "should require a followed_id" do
    @friendship.followed_id = nil
    assert_not @friendship.valid?
  end
end
