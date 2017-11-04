require 'rails_helper'

RSpec.feature 'Admins can view registered users' do
  let(:admin) {FactoryGirl.create(:user, :admin)}
  let!(:user) {FactoryGirl.create(:user)}

  context 'admin users' do
    before do
      login_as(admin)
      visit '/admin/users'
    end

    scenario "list registered users" do
      expect(page).to have_content admin.email
      expect(page).to have_content user.email
    end
  end

end