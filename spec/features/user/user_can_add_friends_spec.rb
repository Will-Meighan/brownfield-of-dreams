require 'rails_helper'

describe 'User' do
  xit 'user can add friend' do
    repo_fixture = File.read('spec/fixtures/repo.json')

    stub_request(:get, "https://api.github.com/user/repos?page=1&per_page=5").
    to_return(status: 200, body: repo_fixture)

    user = create(:user, token: ENV["GITHUB_TEST_TOKEN_2"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
# require "pry"; binding.pry
    visit '/dashboard'

    save_and_open_page

    within "#github-followers" do
      expect(page).to have_link("Add Friend")
    end
  end
end
