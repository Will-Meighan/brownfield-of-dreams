# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  scenario 'can send invite' do
    repo_fixture = File.read('spec/fixtures/repo.json')

    stub_request(:get, 'https://api.github.com/user/repos?page=1&per_page=5')
      .to_return(status: 200, body: repo_fixture)

    user = create(:user, token: ENV['GITHUB_TEST_TOKEN_2'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    click_on 'Send Invite'
    expect(current_path).to eq('/invite')

    fill_in :handle, with: 'kathleen-carroll'

    click_on 'Send Invite'
    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Successfully sent invite!')
    expect(page).to_not have_content("The Github user you selected doesn't have an email address associated with their account.")

    click_on 'Send Invite'
    fill_in :handle, with: 'Will-Meighan'

    click_on 'Send Invite'
    expect(current_path).to eq('/dashboard')
    expect(page).to_not have_content('Successfully sent invite!')
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
