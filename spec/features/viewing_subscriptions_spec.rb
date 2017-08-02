require 'rails_helper'

RSpec.describe 'Viewing subscriptions', type: :feature do
  let(:admin) {FactoryGirl.create(:user, :admin)}
  let!(:subscriber) {FactoryGirl.create(:subscription)}

  before :each do
    login_as admin
    visit subscriptions_path
  end

  it 'list subscribed emails' do
    expect(page).to have_content(subscriber.email)
  end
end
