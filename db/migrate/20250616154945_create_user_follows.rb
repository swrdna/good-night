# frozen_string_literal: true

class CreateUserFollows < ActiveRecord::Migration[7.2]
  def change
    create_table :user_follows do |t|
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followed, null: false, foreign_key: { to_table: :users }

      t.timestamps null: false
    end

    add_index :user_follows, [:follower_id, :followed_id], unique: true
    add_check_constraint :user_follows, "follower_id <> followed_id", name: "follower_cannot_follow_self"
  end
end
