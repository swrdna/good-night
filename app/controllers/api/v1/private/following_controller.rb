# frozen_string_literal: true

module Api::V1::Private
  class FollowingController < PrivateController
    def index
      @following = User.find(params[:user_id]).following
                       .page(params[:page])
                       .per(100)

      render_json @following
    end
  end
end
