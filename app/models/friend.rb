class Friend < ApplicationRecord
  belongs_to :user

  def get_name
    user = User.find(friend_user_id)
    user.username
    # user.first_name + " " + user.last_name
  end
end
