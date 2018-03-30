RSpec.feature 'Registered users can edit their details' do
  let!(:user) { create(:user) }
  let(:password) { 'superSecur3' }

  before do
    login_as(user)
    visit edit_user_registration_path
  end

  context 'successfully' do
    scenario 'with valid credentials' do
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      fill_in 'Current password', with: user.password
      select 'English', from: 'user_locale'
      select 'Male', from: 'user_gender'
      select 'UTC', from: 'user_time_zone'
      fill_in 'Biography', with: Faker::Lorem.paragraph
      click_button 'Update'

      expect(page).to have_content('Your account has been updated successfully.')
      expect(page).to have_current_path(/\/users\/\d+/)
    end

    scenario 'with an image' do
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      fill_in 'Current password', with: user.password
      select 'English'
      select 'Male', from: 'user_gender'
      select 'UTC', from: 'user_time_zone'
      attach_file 'Profile picture', 'spec/fixtures/empty_profile.jpg'
      click_button 'Update'

      expect(page).to have_content('Your account has been updated successfully.')
      expect(page.find('.profile-picture')['src']).to match(/profile_picture\/\d+\/thumb_/)
    end

    scenario 'persisting across form redisplays' do
      attach_file 'Profile picture', 'spec/fixtures/empty_profile.jpg'
      click_button 'Update'

      expect(page).to have_content('error prohibited this user from being saved')

      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Current password', with: user.password
      click_button 'Update'

      expect(page).to have_content('Your account has been updated successfully.')
      expect(page.find('.profile-picture')['src']).to match(/profile_picture\/\d+\/thumb_/)
    end
  end

  context 'unsuccessfully' do
    scenario 'with invalid credentials' do
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Password', with: ''
      click_button 'Update'

      expect(page).to have_content('error prohibited this user from being saved')
    end
  end
end
