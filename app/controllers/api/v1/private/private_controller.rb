# frozen_string_literal: true

module Api::V1::Private
  class PrivateController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    http_basic_authenticate_with name: ENV.fetch("BASIC_AUTH_USERNAME"),
                                 password: ENV.fetch("BASIC_AUTH_PASSWORD")
  end
end
