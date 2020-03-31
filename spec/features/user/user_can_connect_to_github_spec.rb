require 'rails_helper'

describe 'OAuth' do
  before do
    OmniAuth.config.test_mode = true
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  xit "should successfully create a session" do
      session[:user_id].should be_nil
      post :create, provider: :github
      session[:user_id].should_not be_nil
    end

    xit "should redirect the user to the root url" do
      post :create, provider: :github
      response.should redirect_to '/dashboard'
    end

  it 'can validate user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    OmniAuth.config.add_mock(:github, {:uid => '12345',
                                       :name => 'kathleen',
                                       :extra => {:raw_info =>
                                                 {:login => "kathleen-carroll"}},
                                       :credentials => {:token => 'kGig93ethksIId85e'}})

    visit '/dashboard'
    click_on "Connect Github"

    expect(page).to have_content('Repositories')
  end
end
