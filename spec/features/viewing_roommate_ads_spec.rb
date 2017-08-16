require 'rails_helper'

RSpec.describe 'Viewing roommate ads', type: :feature do
  let(:adam) {FactoryGirl.create(:user)}
  let(:bob) {FactoryGirl.create(:user)}
  let!(:advertisement) {FactoryGirl.create(:advertisement, user: bob)}

  before do
    login_as adam
    visit dashboard_path(locale: 'en')
    click_link 'Roommate ads'
  end

  it 'shows available roommate ads' do
    within('.card') do
      expect(page).to have_content(bob.name)
      expect(page).to have_content(advertisement.title)
      expect(page).to have_content(advertisement.body)
    end
  end
end
