require 'rails_helper'

RSpec.feature 'Listing owners can create new listings' do
  let(:owner) {FactoryGirl.create(:user, :owner)}

  before do
    login_as owner
    visit dashboard_path
    click_link 'Add listing'
  end

  scenario 'with valid attributes' do
    listing_name = 'Gangnam house'
    fill_in 'Name', with: listing_name
    select "Apartment", from: "listing_property_type"
    fill_in 'Latitude', with: 37.517235
    fill_in 'Longitude', with: 127.047325
    click_button 'Create Listing'

    expect(page).to have_content 'Listing was created successfully!'

    listing = Listing.find_by(name: listing_name)

    expect(page.current_url).to eq(listing_url(listing))
    expect(Listing.with_role(:owner, owner).first).to eq(listing)
  end

  scenario 'with invalid attributes' do
    click_button 'Create Listing'

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content 'is not in the range -180 to 180'
    expect(page).to have_content 'is not in the range -90 to 90'
  end
end
