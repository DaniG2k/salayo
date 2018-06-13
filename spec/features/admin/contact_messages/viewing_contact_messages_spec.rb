RSpec.feature 'Admins can view contact messages' do
  let(:admin) { create(:user, :admin) }
  let!(:contact_message) { create(:contact_message) }

  context 'admin users' do
    before do
      login_as(admin)
      visit admin_root_path
      click_link 'Contact messages'
    end

    it 'lists contact messages' do
      expect(page).to have_content contact_message.email
    end

    it 'show contact message content' do
      click_link contact_message.email

      expect(page).to have_content contact_message.name
      expect(page).to have_content contact_message.email
      expect(page).to have_content contact_message.body
    end

    it 'redirects safely if the contact message id is not found' do
      visit '/en/admin/contact_messages/123123'

      expect(page).to have_content 'Unable to find that contact message.'
    end
  end
end
