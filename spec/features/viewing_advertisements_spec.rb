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

  it 'shows a list of available roommate ads' do
    within('.card') do
      expect(page).to have_content(bob.name)
      expect(page).to have_content(advertisement.ad_type)
      expect(page).to have_content(advertisement.title)
      expect(page).to have_content(advertisement.body)
    end
  end

  it 'displays a show page' do
    click_link "#{bob.name} - #{advertisement.title}"

    expect(page).to have_content(advertisement.body)
  end

  it 'redirects safely on non-existing advertisements' do
    visit '/en/advertisements/10000'

    expect(page).to have_content('That advertisement does not appear to exist.')
  end
end
