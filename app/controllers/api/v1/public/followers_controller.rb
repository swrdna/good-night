# frozen_string_literal: true

module Api::V1::Public
  class FollowersController < PublicController
    def index
      @followers = User.find(params[:id]).followers

      render_json @followers
    end
  end
end
