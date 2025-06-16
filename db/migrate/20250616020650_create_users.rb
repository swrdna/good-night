# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, limit: 255, null: false

      t.timestamps null: false
    end
  end
end
