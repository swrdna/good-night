# frozen_string_literal: true

module Api::V1::Public
  class FollowingController < PublicController
    def index
      @following = User.find(params[:id]).following

      render_json @following
    end
  end
end
