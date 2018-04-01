RSpec.feature 'Visible links' do
  let(:user) {create :user}
  let(:owner) {create :user, :owner}
  let(:admin) {create :user, :admin}

  context 'Normal user' do
    before do
      login_as user
      visit dashboard_path
    end

    it 'does not show the add listing link' do
      expect(page).not_to have_link 'Add listing'
    end

    it 'does not show the my listings link' do
      expect(page).not_to have_link 'My listings'
    end

    it 'does not show the admin root path' do
      expect(page).not_to have_link 'Admin lounge'
    end

    it 'does not show the Sidekiq link' do
      expect(page).not_to have_link 'Sidekiq'
    end
  end

  context 'Listing owner' do
    before do
      login_as owner
      visit dashboard_path
    end

    it 'shows the add listing link' do
      expect(page).to have_link 'Add listing'
    end

    it 'shows the my listings link' do
      expect(page).to have_link 'My listings'
    end

    it 'does not show the admin root path' do
      expect(page).not_to have_link 'Admin lounge'
    end

    it 'does not show the Sidekiq link' do
      expect(page).not_to have_link 'Sidekiq'
    end
  end

  context 'Admin user' do
    before do
      login_as admin
      visit dashboard_path
    end

    it 'shows the add listing link' do
      expect(page).to have_link 'Add listing'
    end

    it 'shows the my listings link' do
      expect(page).to have_link 'My listings'
    end

    it 'shows the admin root path' do
      expect(page).to have_link 'Admin lounge'
    end

    it 'shows the Sidekiq link' do
      expect(page).to have_link 'Sidekiq'
    end
  end
end
