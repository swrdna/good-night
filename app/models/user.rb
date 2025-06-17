# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleep_sessions, dependent: :destroy

  has_many :follows_given,
           class_name: "UserFollow",
           foreign_key: :follower_id,
           dependent: :destroy
  has_many :follows_received,
           class_name: "UserFollow",
           foreign_key: :followed_id,
           dependent: :destroy

  has_many :following, through: :follows_given, source: :followed
  has_many :followers, through: :follows_received, source: :follower

  def following?(user_id)
    following.exists?(user_id)
  end

  def followed_by?(user_id)
    followers.exists?(user_id)
  end
end
