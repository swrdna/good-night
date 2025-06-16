# frozen_string_literal: true

module Api::V1::Private
  class UserSerializer < ApplicationSerializer
    attributes :id, :name
  end
end
