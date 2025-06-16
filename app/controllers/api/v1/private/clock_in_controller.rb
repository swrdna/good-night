# frozen_string_literal: true

module Api::V1::Private
  class ClockInController < PrivateController
    before_action :set_user

    def create
      @sleep_session = @user.sleep_sessions.new(clock_in_params)

      if @sleep_session.save
        render_json @sleep_session, status: :created
      else
        render_json @sleep_session.errors, status: :unprocessable_entity
      end
    end

    private
      def set_user
        @user = User.find(params[:id])
      end

      def clock_in_params
        params.require(:clock_in).permit(:start_time)
      end
  end
end
