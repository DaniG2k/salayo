RSpec.feature 'Admins can destroy registered users' do
  let(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  context 'admin users' do
    before do
      login_as(admin)
      visit admin_users_path
    end

    scenario "destroy a registered user" do
      expect(User.all.count).to eq(2)

      within('.dashboard-main-content') do
        expect(page).not_to have_content admin.full_name
        find(:css, "a[href=\"/admin/users/#{user.id}\"]").click
      end

      expect(page).to have_content 'User successfully destroyed.'
      expect(User.all.count).to eq(1)
    end
  end

end
