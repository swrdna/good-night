# frozen_string_literal: true

module Api::V1::Private
  class UsersController < PrivateController
    before_action :set_user, only: %i[ show update destroy ]

    def index
      @users = User.order(:created_at)
                   .page(params[:page])
                   .per(100)

      render_json @users
    end

    def show
      render_json @user
    end

    def create
      @user = User.new(user_params)

      if @user.save
        render_json @user, status: :created
      else
        render_json @user.errors, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render_json @user
      else
        render_json @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy!
    end

    private
      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name)
      end
  end
end
