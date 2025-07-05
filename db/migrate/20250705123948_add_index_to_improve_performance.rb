# frozen_string_literal: true

class AddIndexToImprovePerformance < ActiveRecord::Migration[7.2]
  def change
    add_index :users, :name
    add_index :users, :created_at
    add_index :sleep_sessions, :user_id
    add_index :sleep_sessions, :start_time
    add_index :sleep_sessions, :end_time
    add_index :sleep_sessions, [:user_id, :start_time]
    add_index :sleep_sessions, [:user_id, :end_time]
    add_index :user_follows, :follower_id
    add_index :user_follows, :following_id
  end
end
