require 'rails_helper'

RSpec.feature 'Registered users can edit their details' do
  let!(:user) {FactoryGirl.create(:user)}

  before do
    login_as(user)
    visit "/#{user.locale}/users/edit"
  end

  scenario 'with valid credentials' do
    pass = 'superSecur3'
    fill_in 'Email', with: 'new@email.com'
    fill_in 'Password', with: pass
    fill_in 'Password confirmation', with: pass
    fill_in 'Current password', with: 'supersecurep@ss'
    fill_in 'Name', with: 'Bob'
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).to have_current_path(/#{user.locale}\/dashboard/)
  end

  scenario 'with invalid credentials' do
    fill_in 'Email', with: 'new@email.com'
    fill_in 'Password', with: ''
    click_button 'Update'

    expect(page).to have_content('error prohibited this user from being saved')
    expect(page).to have_current_path(/\/users/)
  end
end
