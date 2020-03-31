require 'rails_helper'

describe 'A registered user' do
    scenario 'can view repos with token', :vcr do
        repo_fixture = File.read('spec/fixtures/repo.json')

        stub_request(:get, "https://api.github.com/user/repos?page=1&per_page=5").
        to_return(status: 200, body: repo_fixture)

        user = create(:user, token: ENV["GITHUB_TEST_TOKEN_2"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        expect(page).to have_content("Github Repos")
        expect(page).to have_link("adopt_dont_shop")
        expect(page).to have_link("adopt_dont_shop_paired")
        expect(page).to have_link("b2-mid-mod")
        expect(page).to have_link("backend_module_0_capstone")

    end

    scenario 'cannot see repos without token' do
      user = create(:user, token: nil)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_content("Github Repos")
      expect(page).to_not have_link("adopt_dont_shop")
    end
end
