# frozen_string_literal: true

class SleepSession < ApplicationRecord
  belongs_to :user

  validate :no_active_session, on: :create

  def sleep_duration
    return nil unless start_time && end_time

    duration = end_time - start_time
    hours = (duration / 3600).floor
    minutes = ((duration % 3600) / 60).round

    { hours: hours, minutes: minutes }
  end

  def is_active?
    end_time.nil?
  end

  private

    def no_active_session
      last_session = user.sleep_sessions.order(start_time: :desc).first
      if last_session && last_session.is_active?
        errors.add(:base, "Cannot create new session while there is an active session")
      end
    end
end
