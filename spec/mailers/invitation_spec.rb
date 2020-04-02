require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  describe "When a user sends an invitation email" do
    before :each do
      @user = create(:user, email: "example@gmail.com", username: "kathleen-carroll")
      @user2 = create(:user, email: "example2@gmail.com", first_name: "Will", last_name: "Meighan")
      @email = InvitationMailer.invite(@user, @user2)
    end

    it "has the following subject" do
      expect(@email.subject).to eql("You've been invited to join Turing Video Tutorials!")
    end

    it "has the correct sender's email address" do
      expect(@email.from).to eql(["no-reply@brownfieldofdreams.com"])
    end

    it "has the correct receiving user's email address" do
      expect(@email.to).to eql(["#{@user.email}"])
    end

    it "has the activation url" do
      expect(@email.body.encoded).to match("/signup")
    end
  end
end
