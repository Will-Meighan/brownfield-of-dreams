# frozen_string_literal: true

require 'rails_helper'

describe 'As a Visitor' do
  describe 'when I visit a tutorial show page' do
    describe 'and I click on the bookmark button' do
      it 'displays a flash message alerting me to sign-in to bookmark' do
        tutorial = create(:tutorial)
        video = create(:video, tutorial_id: tutorial.id)
        visit tutorial_path(tutorial)
        click_on 'Bookmark'
        expect(page).to have_content('User must login to bookmark videos.')
        expect(current_path).to eq(tutorial_path(tutorial))
      end
    end
  end
end
