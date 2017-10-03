require 'rails_helper'

RSpec.describe 'Deleting advertisements', type: :feature do
  let(:user1){FactoryGirl.create(:user)}
  let(:user2){FactoryGirl.create(:user)}
  let!(:advert){FactoryGirl.create(:advertisement, user: user1)}

  context "one's own ads" do
    scenario 'successfully' do
      login_as user1
      visit dashboard_path
      within('.column-layout-left') do
        click_link 'My ads'
      end

      click_link advert.title
      click_link 'Delete'

      expect(page).to have_content('Advertisement was successfully destroyed.')
      expect(current_path).to eq('/advertisements/mine')
    end
  end

  context "other people's ads" do
    it "don't have a delete link" do
      login_as user2
      visit dashboard_path
      within('.column-layout-left') do
        click_link 'Roommate ads'
      end

      click_link advert.title
      expect(page).not_to have_link('Delete')
    end
  end
end
