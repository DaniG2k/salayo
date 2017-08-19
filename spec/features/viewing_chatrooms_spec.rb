require 'rails_helper'

RSpec.feature 'Registered users can view chatrooms' do
  let(:user) {FactoryGirl.create(:user)}

  before do
    login_as user
    visit dashboard_path(locale: 'en')
  end

  it 'lists the available chatrooms' do
    click_link 'Messages'

    expect(page).to have_content('Messages')
    expect(current_path).to eq messages_path(locale: 'en')
  end
end
