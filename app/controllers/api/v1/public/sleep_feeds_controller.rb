# frozen_string_literal: true

module Api::V1::Public
  class SleepFeedsController < PublicController
    def index
      user = User.find(params[:id])
      @sleeps = SleepSession.where(user_id: user.following_ids)
                            .includes(:user) 
                            .order([:duration, :created_at])
                            .page(params[:page])
                            .per(100)

      render_json @sleeps
    end
  end
end
