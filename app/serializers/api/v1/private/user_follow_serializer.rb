# frozen_string_literal: true

module Api::V1::Private
  class UserFollowSerializer < ApplicationSerializer
    attributes :followed_id

    attribute :followed_name do |object|
      object.followed.name
    end
  end
end
