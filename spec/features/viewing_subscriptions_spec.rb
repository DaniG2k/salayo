require 'rails_helper'

RSpec.describe 'Viewing subscriptions', type: :feature do
  let(:admin) {FactoryBot.create(:user, :admin)}
  let!(:subscriber) {FactoryBot.create(:subscription)}

  before :each do
    login_as admin
    visit admin_subscriptions_path(locale: admin.locale)
  end

  it 'list subscribed emails' do
    expect(page).to have_content(subscriber.email)
  end
end
