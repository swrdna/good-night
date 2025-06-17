# frozen_string_literal: true

class UserFollow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followed_id, message: "You are already following this user" }
  validate :prevent_self_follow

  private

    def prevent_self_follow
      if follower_id == followed_id
        errors.add(:base, "You cannot follow yourself")
      end
    end
end
