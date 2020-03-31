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
    user_info = request.env['omniauth.auth']

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
