RSpec.describe 'Deleting advertisements' do
  let(:admin) { create(:user, :admin) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:advert) { create(:advertisement, user: user1) }
  let(:delete_link) { "a[title='Delete']" }

  context 'regular users' do
    it 'can destroy their own ads' do
      login_as user1
      visit dashboard_path
      within('.column-layout-left') do
        click_link 'My ads'
      end

      find(delete_link).click

      expect(page).to have_content('Advertisement was successfully destroyed.')
      expect(current_path).to eq("/#{I18n.locale}/advertisements/mine")
    end

    it "other people's ads don't have a delete link" do
      login_as user2
      visit dashboard_path
      within('.column-layout-left') do
        click_link 'Roommate ads'
      end

      expect(page).not_to have_selector(:css, delete_link)
    end
  end
end
