# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleep_sessions, dependent: :destroy
end
