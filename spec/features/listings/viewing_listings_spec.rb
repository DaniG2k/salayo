require 'rails_helper'

RSpec.feature 'Viewing Listings' do

  let(:user) {FactoryGirl.create(:user)}
  let!(:listing) {FactoryGirl.create(:listing)}

  it "doesn't show My listings for users without listings" do
    login_as user
    visit dashboard_path

    expect(page).not_to have_link('My listings')
  end

  it "shows the logged in user's listings" do
    assign_role!(user, :owner, listing)
    login_as user
    visit dashboard_path

    click_link 'My listings'

    expect(page).to have_content(listing.name)
  end

  it 'shows admins all listings' do
    assign_role!(user, :admin)
    login_as user
    visit dashboard_path

    click_link 'My listings'

    expect(page).to have_content(listing.name)
  end
end
