# frozen_string_literal: true

class GithubService
  def initialize(github_token)
    @github_token = github_token
  end

  def get_repos
    get_json('/user/repos?page=1&per_page=5&affiliation=owner')
  end

  def get_followers
    get_json('/user/followers')
  end

  def get_following
    get_json('/user/following')
  end

  def get_user(handle)
    get_json("/users/#{handle}")
  end

  private

  def conn
    Faraday.new(url: 'https://api.github.com/') do |faraday|
      faraday.headers['Authorization'] = "token #{@github_token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
