# frozen_string_literal: true

module Api::V1::Public
  class UsersController < PublicController
    # GET /users
    def index
      @users = User.all

      render_json @users
    end
  end
end
