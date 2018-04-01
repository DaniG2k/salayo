RSpec.feature 'Admins can destroy contact messages' do
  let(:admin) { create(:user, :admin) }
  let!(:contact_message) { create(:contact_message) }

  context 'admin users' do
    before do
      login_as(admin)
      visit admin_root_path
      click_link 'Contact messages'
    end

    it "destroys the contact message successfully" do
      expect(ContactMessage.all.count).to eq(1)

      click_link contact_message.email
      # Delete link has no text. Select it via css
      page.find(:css, "a[href=\"/#{I18n.locale}/admin/contact_messages/#{contact_message.id}\"]").click

      expect(page).to have_content 'Contact message successfully destroyed.'
      expect(ContactMessage.all.count).to eq(0)
    end
  end
end
