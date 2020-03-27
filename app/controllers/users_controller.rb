class UsersController < ApplicationController
  def show
    github = Github.new

    @repos = github.get_data('repos', Repository, current_user)
    @followers = github.get_data('followers', Follower, current_user)
    @following = github.get_data('following', Following, current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
