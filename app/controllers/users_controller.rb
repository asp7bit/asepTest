class UsersController < ApplicationController
  def myFriends
    if params[:email].nil?
      render json: { status: 402, message: "invalid request" }
    else
      friend = User.find_by_email(params[:email])
      friendList = friend ? friend.followers.map(&:email) : []
      render json: { success: true, friends: friendList, count: friendList.count }
    end
  end

  def connectToFriend
    unless params[:friends].any?
      render json: { status: 402, message: "invalid request" }
    else
      friends = []
      params[:friends].each { |email| friends << User.find_or_create_by(email: email, name: email) }
      users = User.where("email in (?)", friends.map(&:email))
      users.each do |user|
        friends.each { |followed| user.follow(followed) if user != followed && !user.following?(followed) }
      end
      render json: { success: true }
    end
  end

  def commonFriends
    unless params[:friends].any?
      render json: { status: 402, message: "invalid request" }
    else
      friends = User.where("email in (?)", params[:friends])
      commonList = []
      if friends.any?
        friends.each { |friend| commonList += friend.following.map(&:email) }
        params[:friends].each { |usr| commonList.delete(usr) }
        render json: { success: true, friends: commonList.uniq, count: commonList.uniq.count }
      else
        render json: { success: true }
      end
    end
  end

  def blockFriend
    requestor = User.find_by_email(params[:requestor])
    target = User.find_by_email(params[:target])
    unless requestor.nil?
      render json: {success: requestor.block(target) ? true : false} if requestor.following?(target)
    else
      render json: {success: false}
    end
  end

  def subscribe
    requestor = User.find_by_email(params[:requestor])
    target = User.find_by_email(params[:target])

    unless requestor.nil?
      render json: {success: requestor.subscribe(target) ? true : false} if requestor.following?(target)
    else
      render json: {success: false}
    end
  end

  def sendEmail
    if params[:sender].nil? || params[:text].nil?
      render json: { status: 402, message: "invalid request" } 
    else
      sender = params[:sender].scan(/\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i)
      text = params[:text].scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i)

      if sender.any?
        user = User.find_by_email(sender)
        recipients = []
        if user.active_friendships.any?
          user.active_friendships.each do |friend| 
            recipients << friend.followed.email unless friend.blocked 
          end
          render json: { success: true, recipients: recipients }
        else
          render json: { success: false }
        end
      end
    end
  end
end
