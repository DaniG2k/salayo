require 'rails_helper'

RSpec.feature 'Listing owners can delete listings' do
  let(:user) {FactoryBot.create(:user)}
  let(:listing) {FactoryBot.create(:listing, owner: user)}

  before do
    user.add_role(:owner, listing)
    login_as user
    visit listings_path
  end

  scenario 'successfully' do
    click_link 'Delete'

    expect(page).to have_content 'Listing was successfully deleted!'
    expect(page.current_url).to eq listings_url
    expect(page).not_to have_content listing.name
  end
end
