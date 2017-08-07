require 'rails_helper'

RSpec.feature 'Viewing Listings' do
  let(:user) {FactoryGirl.create(:user)}
  let!(:listing) {FactoryGirl.create(:listing, owner: user)}

  before do
    login_as user
    visit dashboard_path
  end

  it "shows the logged in user's listings" do
    click_link 'My listings'

    expect(page).to have_content(listing.name)
  end
end
