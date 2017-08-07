require 'rails_helper'

RSpec.feature 'Viewing Listings' do
  let(:owner) {FactoryGirl.create(:user)}
  let(:listing) {FactoryGirl.create(:listing)}

  before do
    owner.add_role(:owner, listing)
    login_as owner
    visit dashboard_path
  end

  it "shows the logged in user's listings" do
    click_link 'My listings'

    expect(page).to have_content(listing.name)
  end
end
