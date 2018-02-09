RSpec.feature 'Registered users can edit their details' do
  let!(:user) {FactoryBot.create(:user)}

  before do
    login_as(user)
    visit edit_user_registration_path
  end

  context 'successfully' do
    scenario 'with valid credentials' do
      pass = 'superSecur3'
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Password', with: pass
      fill_in 'Password confirmation', with: pass
      fill_in 'Current password', with: user.password
      select 'English'
      select 'Male', from: 'user_gender'
      select 'UTC', from: 'user_time_zone'
      click_button 'Update'

      expect(page).to have_content('Your account has been updated successfully.')
      expect(page).to have_current_path(/\/dashboard/)
    end

    scenario 'with an image' do
      pass = 'superSecur3'
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Password', with: pass
      fill_in 'Password confirmation', with: pass
      fill_in 'Current password', with: user.password
      select 'English'
      select 'Male', from: 'user_gender'
      select 'UTC', from: 'user_time_zone'
      attach_file 'Picture', 'spec/fixtures/empty_profile.jpg'
      click_button 'Update'

      expect(page).to have_content('Your account has been updated successfully.')

      within('.profile_picture') do
        expect(page).to have_content('empty_profile.jpg')
      end
    end
  end

  context 'unsuccessfully' do
    scenario 'with invalid credentials' do
      fill_in 'Email', with: 'new@email.com'
      fill_in 'Password', with: ''
      click_button 'Update'

      expect(page).to have_content('error prohibited this user from being saved')
      expect(page).to have_current_path(/\/users/)
    end
  end
end
