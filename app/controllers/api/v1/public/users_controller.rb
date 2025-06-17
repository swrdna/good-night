# frozen_string_literal: true

module Api::V1::Public
  class UsersController < PublicController
    def index
      @users = User.order(:created_at)
                   .page(params[:page])
                   .per(100)

      render_json @users
    end
  end
end
