# frozen_string_literal: true

module Api::V1::Private
  class SleepSessionSerializer < ApplicationSerializer
    attributes :id, :start_time, :end_time, :sleep_duration
  end
end
