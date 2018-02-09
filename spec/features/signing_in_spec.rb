RSpec.feature 'Registered users can sign in' do
  let!(:user) {FactoryBot.create(:user)}

  scenario 'with valid credentials' do
    visit '/login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'supersecurep@ss'
    click_button 'Sign in'

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq dashboard_path
    expect(page).to have_content user.first_name
  end
end
