class InvitesController < ApplicationController
  def new
  end

  def create
    invited = api_conn.get_user(params[:handle])

    if invited.values.include?("Bad credentials")
      flash[:failure] = "Please connect to github before sending invites"
    elsif !invited[:email].nil?
      send_invite(invited, current_user)
      flash[:success] = "Successfully sent invite!"
    elsif invited[:email].nil?
      flash[:failure] = "The Github user you selected doesn't have an email address associated with their account."
    end

    redirect_to '/dashboard'
  end

  private

  def send_invite(github_user, inviter)
    InvitationMailer.invite(github_user, inviter).deliver_now
  end

  def api_conn
    GithubService.new(current_user.token)
  end
end
