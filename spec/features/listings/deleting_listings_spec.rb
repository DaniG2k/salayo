RSpec.feature 'Listing owners can delete listings' do
  let(:user) { create(:user, :owner) }
  let!(:listing) { create(:listing, owner: user) }

  before do
    login_as user
    visit listings_path
  end

  scenario 'successfully' do
    click_link 'Delete'

    expect(page).to have_content 'Listing was successfully deleted!'
    expect(page.current_url).to eq my_listings_url
    expect(page).not_to have_content listing.name
  end
end
