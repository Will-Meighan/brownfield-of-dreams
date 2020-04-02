# frozen_string_literal: true

require 'rails_helper'

describe ActivationMailer, type: :mailer do
  describe 'When a user registers an account and gets an activation email' do
    before :each do
      @user = create(:user, email: 'example@gmail.com')
      @email = ActivationMailer.activate_account(@user)
    end

    it 'has the following subject' do
      expect(@email.subject).to eql('Activate Your Account')
    end

    it "has the correct sender's email address" do
      expect(@email.from).to eql(['no-reply@brownfieldofdreams.com'])
    end

    it "has the correct receiving user's email address" do
      expect(@email.to).to eql([@user.email.to_s])
    end

    it 'has the activation url' do
      expect(@email.body.encoded).to match('/activate')
    end
  end
end
