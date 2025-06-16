# frozen_string_literal: true

module Api::V1::Public
  class PublicController < ApplicationController
    def index
      render json: { status: 'Ok', message: 'Good_Night service is online' }
    end
  end
end
