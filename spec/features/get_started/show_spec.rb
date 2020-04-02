require 'rails_helper'

describe 'As a visitor' do
  it 'can see get started page' do
    visit '/get_started'

    expect(page).to have_content("Get Started")
    expect(page).to have_content("Browse tutorials from the homepage.")
  end
end
