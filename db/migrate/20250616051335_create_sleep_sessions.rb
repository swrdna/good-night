# frozen_string_literal: true

class CreateSleepSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :sleep_sessions do |t|
      t.references :user, foreign_key: true, null: false
      t.datetime :start_time, null: false, default: -> { "CURRENT_TIMESTAMP" }
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
