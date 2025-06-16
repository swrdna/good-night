# frozen_string_literal: true

module Api::V1::Public
  class UserSerializer < ApplicationSerializer
    attributes :name
  end
end
