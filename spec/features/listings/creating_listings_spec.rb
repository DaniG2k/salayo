# TODO
# rewrite these tests using something like Nightwatch.js
#
# require 'rails_helper'
#
# RSpec.feature 'Listing owners can create new listings' do
#   let(:owner) {FactoryGirl.create(:user, :owner)}
#
#   before do
#     login_as owner
#     visit dashboard_path
#     click_link 'Add listing'
#   end
#
#   scenario 'with valid attributes', js: true do
#     listing_name = 'Gangnam house'
#     fill_in 'listing_name', with: listing_name
#     select "Apartment", from: "listing_property_type"
#     click_button 'Next'
#
#     fill_in 'City', with: 'Seoul'
#     fill_in 'State', with: 'South Korea'
#     fill_in 'Address', with: 'Gangnam-gu, Yeoksam-ro 165'
#     click_button 'Next'
#
#     find(:css, "input[type='checkbox'][value='0']").set(true)
#     find(:css, "input[type='checkbox'][value='12']").set(true)
#     find(:css, "input[type='checkbox'][value='18']").set(true)
#
#     click_button 'Create Listing'
#
#     expect(page).to have_content 'Listing was created successfully!'
#
#     listing = Listing.find_by(name: listing_name)
#     expect(current_path).to eq(listing_url(listing))
#     expect(listing.owner).to eq(owner)
#   end
#
#   scenario 'with invalid attributes' do
#     click_button 'Create Listing'
#
#     expect(page).to have_content "Name can't be blank"
#     expect(page).to have_content 'is not in the range -180 to 180'
#     expect(page).to have_content 'is not in the range -90 to 90'
#   end
# end
