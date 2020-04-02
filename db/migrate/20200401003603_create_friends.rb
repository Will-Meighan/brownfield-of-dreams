# frozen_string_literal: true

class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :friend_user_id

      t.timestamps
    end
  end
end
