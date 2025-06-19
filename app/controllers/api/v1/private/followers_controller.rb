# frozen_string_literal: true

module Api::V1::Private
  class FollowersController < PrivateController
    def index
      @followers = User.find(params[:user_id]).followers
                       .page(params[:page])
                       .per(100)

      render_json @followers
    end
  end
end
