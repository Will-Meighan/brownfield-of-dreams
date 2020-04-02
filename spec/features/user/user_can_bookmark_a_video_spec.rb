# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    video = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect do
      click_on 'Bookmark'
    end.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it "can't add the same bookmark more than once" do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on 'Bookmark'
    expect(page).to have_content('Already in your bookmarks')
  end

  it 'can see all bookmarked segments on dashboard' do
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    video_1 = create(:video, tutorial: tutorial_1, position: 1)
    video_2 = create(:video, tutorial: tutorial_1, position: 2)
    video_3 = create(:video, tutorial: tutorial_2, position: 1)
    user = User.create!(email: 'will@example.com', first_name: 'Will', last_name: 'Meighan', password: 'password', role: :default, token: ENV['GITHUB_TEST_TOKEN_2'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial_1)
    click_on 'Bookmark'
    click_on tutorial_1.videos[0].title
    click_on 'Bookmark'

    visit tutorial_path(tutorial_2)
    click_on 'Bookmark'
    click_on tutorial_2.videos[0].title
    click_on 'Bookmark'

    visit dashboard_path

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(video_1.title)

    expect(page).to have_content(tutorial_2.title)
    expect(page).to have_content(video_3.title)
  end
end
