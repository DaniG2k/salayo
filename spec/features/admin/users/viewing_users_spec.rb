RSpec.feature 'Admins can view registered users' do
  let(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  context 'admin users' do
    before do
      login_as(admin)
      visit admin_users_path
    end

    scenario "list registered users" do
      within('.dashboard-main-content') do
        expect(page).not_to have_content admin.full_name
        expect(page).to have_content user.full_name
      end
    end
  end

end
