# frozen_string_literal: true

require 'rails_helper'

describe 'OAuth' do
  before do
    OmniAuth.config.test_mode = true
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  it 'can validate user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    OmniAuth.config.add_mock(:github, { uid: '12345',
                                        extra: { raw_info: { login: 'kathleen-carroll',
                                                             name: 'kathleen' } },
                                        credentials: { token: ENV['GITHUB_TEST_TOKEN_2'] } })

    visit '/dashboard'
    click_on 'Connect Github'

    expect(page).to have_content('Repos')
    expect(page).to have_content('adopt_dont_shop')
    expect(page).to have_content('Followers')
    expect(page).to have_content('kathleen-carroll')
    expect(page).to have_content('theborg10')
    expect(page).to have_content('Following on Github')
    expect(page).to have_content('kathleen-carroll')
  end
end
