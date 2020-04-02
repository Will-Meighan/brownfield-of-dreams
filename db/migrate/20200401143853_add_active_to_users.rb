# frozen_string_literal: true

class AddActiveToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :active?, :boolean, default: false
  end
end
