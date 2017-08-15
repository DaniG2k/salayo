require 'rails_helper'

RSpec.feature 'Signed-in users can sign out' do
  let!(:user) { FactoryGirl.create(:user) }

  before do
    login_as user
  end

  scenario 'with valid credentials' do
    visit dashboard_path(locale: 'en')
    click_link 'Log out'

    expect(page).to have_content 'Signed out successfully'
  end
end
