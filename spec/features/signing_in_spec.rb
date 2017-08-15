require 'rails_helper'

RSpec.feature 'Registered users can sign in' do
  let!(:user) {FactoryGirl.create(:user, locale: 'en')}

  scenario 'with valid credentials' do
    visit '/en/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'supersecurep@ss'
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq dashboard_path(locale: 'en')
    expect(page).to have_content user.name
  end
end
