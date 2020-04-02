# frozen_string_literal: true

class AddUserToFriends < ActiveRecord::Migration[5.2]
  def change
    add_reference :friends, :user, foreign_key: true
  end
end
