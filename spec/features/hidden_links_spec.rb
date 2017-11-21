require 'rails_helper'

RSpec.feature 'Users can only see the appropriate links' do
  let(:user) {FactoryBot.create(:user)}
  let(:owner) {FactoryBot.create(:user, :owner)}
  let(:admin) {FactoryBot.create(:user, :admin)}

  context 'anonymous users' do
    before do
      visit dashboard_path
    end

    scenario 'cannot see the Dashboard link' do
      expect(page).not_to have_link 'Dashboard'
    end

    scenario 'cannot see the Sidekiq link' do
      expect(page).not_to have_link 'Sidekiq'
    end
  end

  context 'regular users' do
    before do
      login_as(user)
      visit dashboard_path
    end

    scenario 'can see the Dashboard link' do
      expect(page).to have_link 'Dashboard'
    end

    scenario 'cannot see the My listings link' do
      expect(page).not_to have_link 'My listings'
    end

    scenario 'cannot see the Subscriptions link' do
      expect(page).not_to have_link 'Subscriptions'
    end

    scenario 'cannot see the Sidekiq link' do
      expect(page).not_to have_link 'Sidekiq'
    end
  end

  context 'listing owners' do
    before do
      login_as(owner)
      visit dashboard_path
    end

    scenario 'can see the Dashboard link' do
      expect(page).to have_link 'Dashboard'
    end

    scenario 'can see the My listings link' do
      expect(page).to have_link 'My listings'
    end

    scenario 'cannot see the Subscriptions link' do
      expect(page).not_to have_link 'Subscriptions'
    end

    scenario 'cannot see the Sidekiq link' do
      expect(page).not_to have_link 'Sidekiq'
    end
  end

  context 'admin users' do
    before do
      login_as(admin)
      visit dashboard_path
    end

    scenario 'can see the Dashboard link' do
      expect(page).to have_link 'Dashboard'
    end

    scenario 'can see the My listings link' do
      expect(page).to have_link 'My listings'
    end

    scenario 'can see the Subscriptions link' do
      expect(page).to have_link 'Subscriptions'
    end

    scenario 'can see the Sidekiq link' do
      expect(page).to have_link 'Sidekiq'
    end
  end
end
