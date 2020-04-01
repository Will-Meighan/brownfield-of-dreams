require 'rails_helper'

describe 'User' do
  it 'user can add friend' do
    user = create(:user, first_name: 'will', token: ENV["GITHUB_TEST_TOKEN_2"], username: 'Will-Meighan')
    user2 = create(:user, first_name: 'kathleen', token: ENV["GITHUB_API_KEY"], username: 'kathleen-carroll')

    repo_fixture = File.read('spec/fixtures/repo.json')

    stub_request(:get, "https://api.github.com/user/repos?page=1&per_page=5").
    to_return(status: 200, body: repo_fixture)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within "#github-followers" do
      expect(page).to have_link("Add Friend", count:1)
      expect(page).to have_content('theborg10')
      expect(page).to have_content('kathleen-carroll')

      click_on "Add Friend"
      expect(page).to_not have_content("Add Friend")
    end

    within "#following" do
      expect(page).to_not have_link("Add Friend")
      expect(page).to have_content('kathleen-carroll')
    end

    within "#friends" do
      expect(page).to have_content("Friends")
      expect(page).to have_content('kathleen-carroll')
      expect(page).to_not have_content('theborg10')
    end
  end
end
