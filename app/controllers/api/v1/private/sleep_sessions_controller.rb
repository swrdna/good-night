# frozen_string_literal: true

module Api::V1::Private
  class SleepSessionsController < PrivateController
    before_action :set_user
    before_action :set_sleep_session, only: %i[ show update destroy ]

    def index
      @sleep_sessions = @user.sleep_sessions

      render_json @sleep_sessions
    end

    def show
      render_json @sleep_session
    end

    def update
      if @sleep_session.update(sleep_session_params)
        render_json @sleep_session
      else
        render_json @sleep_session.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @sleep_session.destroy!
    end

    private
      def set_sleep_session
        @sleep_session = @user.sleep_sessions.find(params[:id])
      end

      def set_user
        @user = User.find(params[:user_id])
      end

      def sleep_session_params
        params.require(:sleep_session).permit(:start_time, :end_time)
      end
  end
end
