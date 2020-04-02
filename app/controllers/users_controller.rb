# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render locals: {
      user_dashboard_facade: UserDashboardFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      # commenting out due to no email in production
      # send_activation_email(user)
      redirect_to dashboard_path
    else
      @user = User.new
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def send_activation_email(user)
    ActivationMailer.activate_account(user).deliver_now
    session[:user_id] = user.id
    flash[:success] = "Logged in as #{user.first_name}."
    flash[:notice] = 'This account has not yet been activated. Please check your email.'
  end
end
