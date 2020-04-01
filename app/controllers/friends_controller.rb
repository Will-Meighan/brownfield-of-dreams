class FriendsController < ApplicationController
  def new
    friend = User.find_by(username: params[:handle])
    user = current_user
    Friend.create(user: user, friend_user_id: friend.id)

    @friends = Friend.joins(:user).where("user_id = #{user.id}")

    redirect_to '/dashboard'
  end
end
