class GithubService
  def user_info(user)
    require "pry"; binding.pry
    user.user_name
    user.uid
    user.token

    params = {username: user.username, #"snippet,contentDetails,statistics"
              uid: user.uid,
              token: user.token}

    get_json("/user/repos", params)
  end

  private

  def get_json(url, params)
    response = conn.get(url, {"Authorization: token #{params[:token]}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com")
    # do |f|
    #   f.adapter  Faraday.default_adapter
    #   f.params[:key] = '56d941ecb3407ba2c26eeee38a59db5006751986'#ENV['GITHUB_API_KEY']
    # end
  end
end
