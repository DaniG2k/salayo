RSpec.describe 'Deleting advertisements', type: :feature do
  let(:admin){FactoryBot.create(:user, :admin)}
  let(:user1){FactoryBot.create(:user)}
  let(:user2){FactoryBot.create(:user)}
  let!(:advert){FactoryBot.create(:advertisement, user: user1)}
  let(:delete_link){"a[title='Delete']"}

  context 'regular users' do
    it 'can destroy their own ads' do
      login_as user1
      visit dashboard_path
      within('.column-layout-left') do
        click_link 'My ads'
      end

      find(delete_link).click

      expect(page).to have_content('Advertisement was successfully destroyed.')
      expect(current_path).to eq('/advertisements/mine')
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
