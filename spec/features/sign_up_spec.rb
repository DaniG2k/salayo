RSpec.feature 'Users can sign up' do
  let(:password) {'secur3p@ass'}
  let(:email) {Faker::Internet.email}
  let(:bio) {Faker::Lorem.paragraph(2)}

  before do
    visit new_user_registration_path
  end

  context 'successfully' do
    it 'create normal user and go to dashboard' do
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: email
      fill_in 'user_password', with: password
      fill_in 'Password confirmation', with: password
      select 'Regular user', from: 'user_role'
      select 'English', from: 'Language'
      select '1', from: 'user_birth_date_3i'
      select 'January', from: 'user_birth_date_2i'
      select '1987', from: 'user_birth_date_1i'
      select 'Female', from: 'Gender'
      select 'UTC', from: 'Time zone'
      fill_in 'About you', with: bio
      click_button 'Sign up'

      user = User.find_by_email email

      # Ensure additional params are passing.
      expect(user.gender).to eq('female')
      expect(user.role).to eq('user')
      expect(user.biography).to eq(bio)
      expect(page).to have_content 'You have signed up successfully.'
      expect(page).to have_current_path(dashboard_path)
    end

    it 'allows an undisclosed gender' do
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: email
      fill_in 'user_password', with: password
      fill_in 'Password confirmation', with: password
      select 'Regular user', from: 'user_role'
      select '日本語', from: 'Language'
      select '1', from: 'user_birth_date_3i'
      select 'January', from: 'user_birth_date_2i'
      select '1987', from: 'user_birth_date_1i'
      select 'Undisclosed', from: 'Gender'
      select 'UTC', from: 'Time zone'
      fill_in 'About you', with: bio
      click_button 'Sign up'

      user = User.find_by_email email

      # Ensure additional params are passing.
      expect(user.gender).to eq(nil)
      expect(user.role).to eq('user')
      expect(user.biography).to eq(bio)
      expect(page).to have_content 'You have signed up successfully.'
    end

    it 'create an owner and go to dashboard' do
      fill_in 'First name', with: Faker::Name.first_name
      fill_in 'Last name', with: Faker::Name.last_name
      fill_in 'Email', with: email
      fill_in 'user_password', with: password
      fill_in 'Password confirmation', with: password
      select 'Property owner', from: 'user_role'
      select 'English', from: 'Language'
      select '1', from: 'user_birth_date_3i'
      select 'January', from: 'user_birth_date_2i'
      select '1987', from: 'user_birth_date_1i'
      select 'Male', from: 'Gender'
      select 'Seoul', from: 'Time zone'
      fill_in 'About you', with: bio
      click_button 'Sign up'

      user = User.find_by_email email

      # Ensure additional params are passing.
      expect(user.gender).to eq('male')
      expect(user.role).to eq('owner')
      expect(user.biography).to eq(bio)
      expect(page).to have_content 'You have signed up successfully.'
      expect(page).to have_current_path(dashboard_path)
    end
  end

  context 'unsuccessfully' do
    it 'displays the appropriate errors' do
      fill_in 'First name', with: ''
      click_button 'Sign up'

      expect(page).to have_content('errors prohibited this user from being saved')
      expect(page).to have_content("First name can't be blank")
    end
  end
end
