require 'rails_helper'

describe "As an admin user" do
  describe "when I visit my admin dashboard" do
    describe "I click on the delete button next to a tutorial" do
      scenario  "the tutorial is deleted along with its videos" do
        admin = create(:user, role: :admin)
        tutorial_1 = create(:tutorial)
        tutorial_2 = create(:tutorial)
        tutorial_3 = create(:tutorial)

        video_1 = create(:video, tutorial: tutorial_1)
        video_2 = create(:video, tutorial: tutorial_2)
        video_3 = create(:video, tutorial: tutorial_3)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit '/admin/dashboard'

        expect(page).to have_css(".admin-tutorial-card", count: 3)

        within("#tutorial-#{tutorial_1.id}") do
          expect {
            click_link 'Delete'
          }.to change { Tutorial.count }.by(-1)
            .and change { Video.count }.by(-1)
        end

        expect(current_path).to eq('/admin/dashboard')

        expect(page).to have_css(".admin-tutorial-card", count: 2)
        expect(page).to_not have_css("#tutorial-#{tutorial_1.id}")
        expect(Video.find_by(id: video_1.id)).to eq(nil)
      end
    end
  end
end
