require 'rails_helper'

RSpec.describe "Tutorials Index Page" do
  before :each do
    @tutorial1 = create(:tutorial, title: "tutorial 1", description: "tutorial 1")
    @tutorial2 = create(:tutorial, title: "tutorial 2", description: "tutorial 2", classroom: true)
    @tutorial3 = create(:tutorial, title: "tutorial 3", description: "tutorial 3", classroom: true)
  end

  describe "as a visitor" do
    it "I only see tutorials that are not classroom content" do
      visit tutorials_path

      expect(page).to have_css('.tutorial', count: 1)

      within("#tutorial-#{@tutorial1.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(@tutorial1.title, href: tutorial_path(@tutorial1.id))
        expect(page).to have_content(@tutorial1.description)
      end
      expect(page).to_not have_content(@tutorial2.title)
      expect(page).to_not have_content(@tutorial2.description)

      expect(page).to_not have_content(@tutorial3.title)
      expect(page).to_not have_content(@tutorial3.description)
    end
  end

  describe "as a logged in user" do
    it "I see all videos" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit tutorials_path

      expect(page).to have_css('.tutorial', count: 3)

      within("#tutorial-#{@tutorial1.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(@tutorial1.title, href: tutorial_path(@tutorial1.id))
        expect(page).to have_content(@tutorial1.description)
      end

      within("#tutorial-#{@tutorial2.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(@tutorial2.title, href: tutorial_path(@tutorial2.id))
        expect(page).to have_content(@tutorial2.description)
      end

      within("#tutorial-#{@tutorial3.id}") do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_link(@tutorial3.title, href: tutorial_path(@tutorial3.id))
        expect(page).to have_content(@tutorial3.description)
      end
    end
  end
end
