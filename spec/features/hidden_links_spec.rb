require 'rails_helper'

RSpec.feature 'Users can only see the appropriate links' do
  let(:user) {FactoryGirl.create(:user)}
  let(:owner) {FactoryGirl.create(:user, :owner)}
  let(:admin) {FactoryGirl.create(:user, :admin)}

  context 'anonymous users' do
    scenario 'cannot see the Dashboard link' do
      visit dashboard_path
      expect(page).not_to have_link 'Dashboard'
    end
  end

  context 'regular users' do
    before { login_as(user) }

    scenario 'can see the Dashboard link' do
      visit dashboard_path
      expect(page).to have_link 'Dashboard'
    end

    scenario 'cannot see the My listings link' do
      visit dashboard_path
      expect(page).not_to have_link 'My listings'
    end

    scenario 'cannot see the Subscriptions link' do
      visit dashboard_path
      expect(page).not_to have_link 'Subscriptions'
    end
  end

  context 'listing owners' do
    before { login_as(owner) }

    scenario 'can see the Dashboard link' do
      visit dashboard_path
      expect(page).to have_link 'Dashboard'
    end

    scenario 'can see the My listings link' do
      visit dashboard_path
      expect(page).not_to have_link 'My listings'
    end

    scenario 'cannot see the Subscriptions link' do
      visit dashboard_path
      expect(page).not_to have_link 'Subscriptions'
    end
  end

  context 'admin users' do
    before { login_as(admin) }

    scenario 'can see the Dashboard link' do
      visit dashboard_path
      expect(page).to have_link 'Dashboard'
    end

    scenario 'can see the My listings link' do
      visit dashboard_path
      expect(page).to have_link 'My listings'
    end

    scenario 'can see the Subscriptions link' do
      visit dashboard_path
      expect(page).to have_link 'Subscriptions'
    end
  end
end
