RSpec.feature 'Users can message each other from chatrooms' do
  let(:user) { create(:user) }
  let(:owner) { create(:user, :owner) }
  let(:amenity_list) { create(:amenity_list) }
  let(:listing) { create(:listing, owner: owner, amenity_list: amenity_list) }

  before do
    login_as user
    visit listing_path(listing)
  end

  context 'successfully' do
    it 'redirects to a chatroom page' do
      owner_name = owner.first_name
      click_link "Message #{owner_name}"

      expect(page).to have_content("Conversation with #{owner_name}")
    end
  end
end
