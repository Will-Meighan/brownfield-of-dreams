class UsersController < ApplicationController
  def show
    github = GithubService.new
    raw_repos = github.user_info(current_user, 'repos')

    if raw_repos.count == 2
      @repos = nil
    else
      @repos = raw_repos.map do |row|
        Repository.create(url: row[:owner][:html_url], name: row[:name])
      end
    end

    raw_followers = github.user_info(current_user, 'followers')

    if raw_followers.count == 2 || raw_followers == []
      @followers = nil
    else
      @followers = raw_followers.map do |row|
        Follower.create(url: row[:html_url], name: row[:login])
      end
    end

    raw_following = github.user_info(current_user, 'following')

    if raw_following.count == 2 || raw_following == []
      @following = nil
    else
      @following = raw_following.map do |row|
        Following.create(url: row[:html_url], name: row[:login])
      end
    end
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
