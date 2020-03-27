class Github
  def get_data(uri, klass, user)
    github = GithubService.new
    raw = github.user_info(user, uri)

    if (raw.class == Hash && raw.values.include?("Bad credentials")) || raw == []
      nil
    elsif raw.first[:owner].class == Hash
      raw.map do |row|
        klass.create(url: row[:owner][:html_url], name: row[:name])
      end
    else
      raw.map do |row|
        klass.create(url: row[:html_url], name: row[:login])
      end
    end
  end
end
