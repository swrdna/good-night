# frozen_string_literal: true

module Api::V1::Public
  class SleepSessionSerializer < ApplicationSerializer
    attributes :id, :start_time, :end_time, :duration, :duration_text

    attribute :user do |object|
      {
        id: object.user_id,
        name: object.user.name
      }
    end
  end
end
