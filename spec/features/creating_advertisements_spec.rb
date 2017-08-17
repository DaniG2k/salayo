require 'rails_helper'

RSpec.describe 'Creating advertisements', type: :feature do
  let(:user){FactoryGirl.create(:user)}

  before do
    login_as user
    visit dashboard_path(locale: 'en')
    click_link 'Create ad'
  end

  scenario 'successfully' do
    fill_in 'Title', with: 'This is my ad'
    fill_in 'Body', with: 'I am looking for a place to stay in Seoul.'
    select 'Wanted', from: 'advertisement[ad_type]'
    click_button 'Create Advertisement'

    expect(page).to have_content('Advertisement was successfully created.')
  end

  scenario 'unsuccessfully' do
    fill_in 'Title', with: ''
    click_button 'Create Advertisement'

    expect(page).to have_content('errors prohibited this advertisement from being saved')
  end
end
