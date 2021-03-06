RSpec.describe 'Viewing roommate ads' do
  let(:alice) { create(:user) }
  let(:bob) { create(:user) }
  let!(:advertisement1) { create(:advertisement, user: alice) }
  let!(:advertisement2) { create(:advertisement, user: bob) }

  context "a user's own ads" do
    before do
      login_as alice
      visit dashboard_path
      within('.column-layout-left') do
        click_link 'My ads'
      end
    end

    it "shows a list of the currently logged in user's ads" do
      within('.card') do
        expect(page).to have_content(advertisement1.ad_type)
        expect(page).to have_content(advertisement1.title)
        expect(page).to have_content(advertisement1.body)
      end
    end
  end

  context "other users' ads" do
    before do
      login_as alice
      visit dashboard_path
      within('.column-layout-left') do
        click_link 'Roommate ads'
      end
    end

    it 'shows a list of available roommate ads' do
      within('.dashboard-main-content') do
        expect(page).not_to have_content(alice.first_name)

        expect(page).to have_content(bob.first_name)
        expect(page).to have_content(advertisement2.ad_type)
        expect(page).to have_content(advertisement2.title)
        expect(page).to have_content(advertisement2.body)
      end
    end

    it 'displays a show page' do
      find("a[title='Show']").click

      expect(page).to have_content(advertisement2.body)
    end

    it 'redirects safely on non-existing advertisements' do
      visit advertisement_path '10000'

      expect(page).to have_content('That advertisement does not appear to exist.')
    end
  end
end
