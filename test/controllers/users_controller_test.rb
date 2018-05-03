require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:andi)
  end

  test "should get list my friends" do
    assert_no_difference 'User.count' do
      post friends_url, params: { email: @user.email }
    end
    assert_response :success
  end

  test "should be connected" do
    assert_difference '@user.following.count', 1 do
      post connect_url, params: { friends: [@user.email, "rudi@example.com"] }
    end
    assert_response :success
  end

  test "should be list common friends from between email andi and lisa" do
    post common_friends_url, params: { friends: [@user.email, "lisa@example.com"] }
    assert_response :success
  end

  test "should be subscribe friend by an email" do
    post subscribe_url, params: { requestor: "andi@example.com", target: "lisa@example.com" }
    assert_response :success
  end

  test "should be block friend by an email" do
    post block_url, params: { requestor: "andi@example.com", target: "lisa@example.com" }
    assert_response :success
  end

  test "should be send an email" do
    post send_email_url, params: { sender: "andi@example.com", text: "hello lisa@example.com" }
    assert_response :success
  end
end
