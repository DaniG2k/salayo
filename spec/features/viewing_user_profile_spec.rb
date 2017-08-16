require 'rails_helper'

RSpec.feature 'Registered users can view their details' do
  let(:user) {FactoryGirl.create(:user)}
  let(:owner) {FactoryGirl.create(:user, :owner)}
  let(:admin) {FactoryGirl.create(:user, :admin)}
  let(:deny_msg) {'You are not allowed to access that resource.'}

  context 'anonymous users' do
    scenario 'cannot see the profile page' do
      visit user_path(locale: user.locale, id: user)
      expect(page).not_to have_content user.email

      visit user_path(locale: user.locale, id: owner)
      expect(page).not_to have_content owner.email

      visit user_path(locale: user.locale, id: admin)
      expect(page).not_to have_content admin.email
    end
  end

  context 'regular users' do
    before { login_as(user) }

    scenario 'can see their own profile page' do
      visit user_path(locale: user.locale, id: user)
      expect(page).to have_content user.email
    end

    scenario "cannot see other users' profile pages" do
      visit user_path(locale: user.locale, id: owner)
      expect(page).not_to have_content owner.email
      expect(page).to have_content(deny_msg)

      visit user_path(locale: user.locale, id: admin)
      expect(page).not_to have_content admin.email
      expect(page).to have_content(deny_msg)
    end
  end

  context 'listing owners' do
    before { login_as(owner) }

    scenario 'can see their own profile page' do
      visit user_path(locale: user.locale, id: owner)
      expect(page).to have_content owner.email
    end

    scenario "cannot see other users' profile pages" do
      visit user_path(locale: user.locale, id: user)
      expect(page).not_to have_content user.email
      expect(page).to have_content(deny_msg)

      visit user_path(locale: user.locale, id: admin)
      expect(page).not_to have_content admin.email
      expect(page).to have_content(deny_msg)
    end
  end

  context 'admin users' do
    before { login_as(admin) }

    scenario 'can see their own profile page' do
      visit user_path(locale: user.locale, id: admin)
      expect(page).to have_content admin.email
    end

    scenario "can see other users' profile pages" do
      visit user_path(locale: user.locale, id: user)
      expect(page).to have_content user.email

      visit user_path(locale: user.locale, id: owner)
      expect(page).to have_content owner.email
    end
  end
end
