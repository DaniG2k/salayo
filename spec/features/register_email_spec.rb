describe 'Registering users emails', type: :feature do
  before :each do
    visit root_path
  end

  it 'has a subscribe form' do
    within(".pill") do
      fill_in 'subscription_email', with: 'test@email.com'
      click_button 'Subscribe'
    end

    expect(page).to have_content 'Thanks for subscribing!'
  end

  it "doesn't allow blank emails" do
    within(".pill") do
      fill_in 'subscription_email', with: ' '
      click_button 'Subscribe'
    end

    expect(page).to have_content "Email can't be blank"
  end

  it "doesn't allow dupliacte emails" do
    2.times do
      within(".pill") do
        fill_in 'subscription_email', with: 'test@email.com'
        click_button 'Subscribe'
      end
    end

    expect(page).to have_content 'Email has already been taken'
  end
end
