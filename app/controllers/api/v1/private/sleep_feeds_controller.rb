# frozen_string_literal: true

module Api::V1::Private
  class SleepFeedsController < PrivateController
    def index
      user = User.find(params[:user_id])
      @sleeps = SleepSession.where(user_id: user.following_ids)
                            .from_last_week
                            .includes(:user)
                            .order([ :duration, :created_at ])
                            .page(params[:page])
                            .per(100)

      render_json @sleeps, serializer: SleepFeedSerializer
    end
  end
end
