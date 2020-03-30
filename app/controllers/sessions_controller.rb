class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = "Looks like your email or password is invalid"
      render :new
    end
  end

  def github
    # require "pry"; binding.pry
    user_info = request.env['omniauth.auth']
    # client_id     = ENV['GITHUB_CLIENT_ID']
    # client_secret = ENV['GITHUB_CLIENT_SECRET']
    # code          = params[:code]
    # response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    #
    # pairs = response.body.split("&")
    # response_hash = {}
    # pairs.each do |pair|
    #   key, value = pair.split("=")
    #   response_hash[key] = value
    # end
    #
    # token = response_hash["access_token"]
    #
    # oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")
    #
    # auth = JSON.parse(oauth_response.body)

    user = current_user
    user.update_attribute(:username, user_info[:extra][:raw_info][:login])
    user.update_attribute(:uid, user_info[:extra][:raw_info][:id])
    user.update_attribute(:token, user_info[:credentials][:token])

    session[:user_id] = user.id

    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
