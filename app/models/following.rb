class Following
  attr_reader :handle, :url, :uid

  def initialize(info)
    @handle = info[:login]
    @url = info[:html_url]
    @uid = info[:id]
  end

  def addable?
    !User.find_by(username: self.handle).nil?
    # User.where("token != null")
  end

  def already_friend?
    user = User.find_by(username: self.handle)
    !Friend.joins(:user).where("friend_user_id = #{user.id}").first.nil? if !user.nil?
  end

end
