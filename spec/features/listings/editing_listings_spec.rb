require 'rails_helper'

RSpec.feature 'Listing owners can edit existing listings' do
  let(:user) {FactoryGirl.create(:user, locale: 'en')}
  let(:listing) {FactoryGirl.create(:listing, owner: user)}

  before do
    user.add_role(:owner, listing)
    login_as user
    visit edit_listing_path(locale: user.locale, id: listing)
  end

  scenario 'with valid attributes' do
    new_name = 'Busan-3'
    fill_in 'Name', with: new_name
    click_button 'Update Listing'

    expect(page).to have_content 'Listing has been updated!'
    expect(page).to have_content new_name
  end

  scenario 'with invalid attributes' do
    fill_in 'Name', with: ''
    click_button 'Update Listing'

    expect(page).to have_content 'prohibited this listing from being saved'
    end
end
