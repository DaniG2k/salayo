RSpec.feature 'Registered users can soft delete their accounts' do
  let(:user) {create(:user)}
  let(:owner) {create(:user, :owner)}

  context 'Normal user' do
    before do
      login_as user
      visit edit_user_registration_path
    end

    it "soft delete one's account" do
      expect(User.count).to eq(1)
      click_button 'Cancel my account'

      expect(User.count).to eq(1)
      expect(User.first.deleted_at).not_to be_nil
    end
  end

  context 'Listing owner' do
    before do
      login_as owner
      visit edit_user_registration_path
    end

    it "soft delete one's account" do
      expect(User.count).to eq(1)
      click_button 'Cancel my account'

      expect(User.count).to eq(1)
      expect(User.first.deleted_at).not_to be_nil
    end
  end
end
