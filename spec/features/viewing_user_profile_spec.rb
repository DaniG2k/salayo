require 'rails_helper'

RSpec.feature 'Registered users can view their details' do
  let!(:user) {FactoryGirl.create(:user)}

  before do
    login_as(user)
    visit user_path(user)
  end

  scenario 'successfully' do
    expect(page).to have_content user.email
  end
end
