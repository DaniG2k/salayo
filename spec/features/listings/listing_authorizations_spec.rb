RSpec.feature 'Listing authorizations' do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:owner) { create(:user, :owner) }
  let(:listing) { create(:listing, owner: owner) }
  let(:auth_msg) { 'You are not allowed to access that resource.' }

  context 'admins' do
    it "can access users' listings#edit" do
      login_as admin
      visit edit_listing_path(listing)

      expect(page).to have_current_path(edit_listing_path(listing))
      expect(page).not_to have_content auth_msg
    end
  end

  context 'authorized users' do
    it 'can access listings#edit' do
      login_as owner
      visit edit_listing_path(listing)

      expect(page).to have_current_path(edit_listing_path(listing))
      expect(page).not_to have_content auth_msg
    end
  end

  context 'unauthorized users' do
    it 'cannot access listings#edit' do
      login_as user
      visit edit_listing_path(listing)

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content auth_msg
    end
  end
end
