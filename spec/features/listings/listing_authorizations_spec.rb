RSpec.feature 'Listing authorizations' do
  let(:user) {FactoryBot.create(:user)}
  let(:another_user) {FactoryBot.create(:user)}
  let(:listing) {FactoryBot.create(:listing, owner: another_user)}

  before do
    login_as user
    visit edit_listing_path(listing)
  end

  scenario 'unauthorized users' do
    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content 'You are not allowed to access that resource.'
  end
end
