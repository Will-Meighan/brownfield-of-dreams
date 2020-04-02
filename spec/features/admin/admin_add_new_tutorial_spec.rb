# frozen_string_literal: true

require 'rails_helper'

describe 'As an admin user' do
  it 'adds new tutorial' do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)

    title = 'Mr. Rob West'
    description = "And then of course I've got this terrible pain in all the diodes down my left side."
    thumbnail = 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/tutorials/new'

    fill_in 'tutorial[title]', with: tutorial.title
    fill_in 'tutorial[description]', with: tutorial.description
    fill_in 'tutorial[thumbnail]', with: tutorial.thumbnail

    click_on 'Save'

    new_tutorial = Tutorial.last

    expect(current_path).to eq("/tutorials/#{new_tutorial.id}")
    expect(page).to have_content('Successfully created tutorial')
  end
end
