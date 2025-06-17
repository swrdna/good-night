# frozen_string_literal: true

class AddColumnDurationToSleepSession < ActiveRecord::Migration[7.2]
  def change
    add_column :sleep_sessions, :duration, :integer
  end
end
