describe 'Contact mailer' do
  context 'successfully' do
    it 'properly sends an email' do
      visit new_contact_message_path
      fill_in 'Name', with: Faker::Name.name
      fill_in 'Email', with: Faker::Internet.email
      fill_in 'Message', with: 'Test message :) cool website'
      click_button 'Send'

      expect(page).to have_content I18n.t('contact_message_mailer.message_received')
    end
  end

  context 'unsuccessfully' do
    it 'returns an error messsage' do
      visit new_contact_message_path
      fill_in 'Name', with: ''
      fill_in 'Email', with: ''
      fill_in 'Message', with: 'Test message :) cool website'
      click_button 'Send'

      expect(page).to have_content('There seems to have been a problem')
    end
  end
end
