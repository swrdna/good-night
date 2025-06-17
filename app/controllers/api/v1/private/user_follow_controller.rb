# frozen_string_literal: true

module Api::V1::Private
  class UserFollowController < PrivateController
    before_action :set_user

    def create
      @user_follow = @user.follows_given.new(followed_id: params[:target_user_id])

      if @user_follow.save
        render_json @user_follow, status: :created
      else
        render_json @user_follow.errors, status: :unprocessable_entity
      end
    end

    def destroy
      user_follow = @user.follows_given.find_by_followed_id(params[:target_user_id])

      unless user_follow&.destroy
        head :not_found
      end
    end

    private

      def set_user
        @user = User.find(params[:id])
      end
  end
end
