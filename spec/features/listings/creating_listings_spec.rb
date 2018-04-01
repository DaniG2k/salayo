RSpec.feature 'Listing owners can create new listings' do
  let(:owner) { create(:user, :owner) }

  before do
    login_as owner
    visit new_listing_path
  end

  context 'successfully' do
    it 'returns a success message', js: true do
      fill_in 'Property name', with: 'Example property'
      select 'Apartment', from: 'Property type'
      fill_in 'Bedrooms', with: 1
      fill_in 'Beds', with: 2
      fill_in 'Bathrooms', with: 2
      select '$ - USD', from: 'Price currency'
      fill_in 'Price per week', with: 210.0
      click_button 'Next'

      fill_in 'City', with: 'Seoul'
      fill_in 'State', with: 'South Korea'
      fill_in 'Address', with: 'Garosu-gil'
      click_button 'Next'

      find(:label, 'Air conditioning').click
      find(:label, 'Gym').click
      find(:label, 'Washer').click
      click_button 'Next'

      fill_in 'Property description', with: Faker::Lorem.paragraph(2)
      click_button 'Create Listing'

      expect(page).to have_content 'Listing was created successfully.'
    end
  end

  context 'unsuccessfully' do
    it 'returns an error message', js: true do
      click_button 'Next'
      click_button 'Next'
      click_button 'Next'
      click_button 'Create Listing'

      expect(page).to have_content 'Listing has not been created.'
    end
  end
end
