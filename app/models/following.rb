# frozen_string_literal: true

class Following
  attr_reader :handle, :url, :uid

  def initialize(info)
    @handle = info[:login]
    @url = info[:html_url]
    @uid = info[:id]
  end

  def addable?
    !User.find_by(username: handle).nil?
    # User.where("token != null")
  end

  def already_friend?
    user = User.find_by(username: handle)
    unless user.nil?
      !Friend.joins(:user).where("friend_user_id = #{user.id}").first.nil?
    end
  end
end
