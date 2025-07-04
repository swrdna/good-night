# frozen_string_literal: true

module Api::V1::Public
  class SleepFeedsController < PublicController
    def index
      @sleeps = SleepSession.from_last_week
                            .includes(:user)
                            .order([ :duration, :created_at ])
                            .page(params[:page])
                            .per(100)

      render_json @sleeps
    end
  end
end
