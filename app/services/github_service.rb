class GithubService
  def user_info(user)
    params = {username: user.username,
              uid: user.uid,
              token: user.token}

    get_json("/user/repos", params)
  end

  private

  def get_json(url, params)
    access_token = params[:token]
    response = conn.get(url, {authorization: conn.headers[:authorization]})
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com") do |f|
      f.headers[:authorization] = "token #{ENV["GITHUB_API_KEY"]}"
    end
  end
end
