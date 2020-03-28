class Follower
  attr_reader :handle, :url, :uid

  def initialize(info)
    @handle = info[:login]
    @url = info[:html_url]
    @uid = info[:id]
  end

end
