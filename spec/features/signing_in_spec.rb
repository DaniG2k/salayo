RSpec.feature 'Registered users can sign in' do
  let!(:user) { create(:user) }

  scenario 'with valid credentials' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq dashboard_path
    expect(page).to have_content user.first_name
  end
end
