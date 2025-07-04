# frozen_string_literal: true

class SleepSession < ApplicationRecord
  belongs_to :user

  validate :no_active_session, on: :create
  validate :end_time_after_start_time
  validates :start_time, presence: true, on: :update
  validates :end_time, presence: true, on: :update

  before_update :set_duration

  scope :from_last_week, -> { where("created_at >= ?", 1.week.ago) }

  def is_active?
    end_time.nil?
  end

  def duration_text
    return nil if duration.nil?

    hours = duration / 3600
    minutes = (duration % 3600) / 60

    "#{hours}h #{minutes}m"
  end

  private

    def no_active_session
      last_session = user.sleep_sessions.order(start_time: :desc).first
      if last_session && last_session.is_active?
        errors.add(:base, "Cannot create new session while there is an active session")
      end
    end

    def end_time_after_start_time
      return if end_time.blank? || start_time.blank?
      if end_time <= start_time
        errors.add(:end_time, "must be greater than start time")
      end
    end

    def set_duration
      self.duration = (end_time - start_time).to_i if end_time_changed? || start_time_changed?
    end
end
