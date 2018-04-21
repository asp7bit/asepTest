class User < ApplicationRecord
  has_many :active_friendships, class_name:  "Friendship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  has_many :following, through: :active_friendships, source: :followed
  has_many :passive_friendships, class_name:  "Friendship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_friendships, source: :follower
  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # Follows a user.
  def follow(other_user)
    active_friendships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_friendships.find_by(followed_id: other_user.id).destroy
  end

  def block(other_user)
    active_friendships.find_by(followed_id: other_user.id).update(blocked: true)
  end

  def block(other_user)
    active_friendships.find_by(followed_id: other_user.id).update(blocked: false)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
end
