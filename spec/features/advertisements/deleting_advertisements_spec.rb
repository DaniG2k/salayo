require 'rails_helper'

RSpec.describe 'Deleting advertisements', type: :feature do
  let(:user){FactoryGirl.create(:user)}
  let!(:advert){FactoryGirl.create(:advertisement, user: user)}

  before do
    login_as user
    visit dashboard_path
    within('.column-layout-left') do
      click_link 'My ads'
    end
  end

  scenario 'successfully' do
    click_link advert.title
    click_link 'Delete'

    expect(page).to have_content('Advertisement was successfully destroyed.')
    expect(current_path).to eq('/advertisements/mine')
  end
end
