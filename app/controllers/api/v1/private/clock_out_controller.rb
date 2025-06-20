# frozen_string_literal: true

module Api::V1::Private
  class ClockOutController < PrivateController
    before_action :set_user

    def update
      @sleep_session = @user.sleep_sessions.order(created_at: :desc).first

      if @sleep_session.update(clock_out_params)
        render_json @sleep_session
      else
        render_json @sleep_session.errors, status: :unprocessable_entity
      end
    end

    private
      def set_user
        @user = User.find(params[:id])
      end

      def clock_out_params
        params.require(:clock_out).permit(:end_time)
      end
  end
end
