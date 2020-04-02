class InvitationMailer < ApplicationMailer
  def invite(github_user, inviter)
    @name = github_user[:name]
    @inviter = inviter[:first_name] + " " + inviter[:last_name]
    mail(to: github_user[:email], subject: "You've been invited to join Turing Video Tutorials!")
  end
end
