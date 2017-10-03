require 'rails_helper'

RSpec.feature 'Viewing Listings' do

  let(:regular_user) {FactoryGirl.create(:user)}
  let!(:user1) {FactoryGirl.create(:user)}
  let!(:user2) {FactoryGirl.create(:user)}
  let!(:listing1) {FactoryGirl.create(:listing, owner: user1)}
  let!(:listing2) {FactoryGirl.create(:listing, owner: user2)}

  it "doesn't show My listings for users without listings" do
    login_as regular_user
    visit dashboard_path(locale: regular_user.locale)

    expect(page).not_to have_link('My listings')
  end

  it "shows the logged in user's listings" do
    assign_role!(user1, :owner, listing1)
    login_as user1
    visit dashboard_path(locale: user1.locale)

    click_link 'My listings'

    expect(page).to have_content(listing1.name)
  end

  it 'shows admins all listings' do
    assign_role!(user2, :admin)
    login_as user2
    visit dashboard_path(locale: user2.locale)

    click_link 'My listings'

    expect(page).to have_content(listing1.name)
    expect(page).to have_content(listing2.name)
  end

  it 'redirects to a safe place when a listing id is not found' do
    login_as regular_user
    visit '/listings/abc'

    expect(page).to have_content('That listing does not appear to exist.')
  end
end
