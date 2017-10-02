require 'rails_helper'

RSpec.describe AdvertisementPolicy do

  subject { described_class }

  permissions :show? do
    let(:user) {FactoryGirl.create(:user)}
    let(:owner) {FactoryGirl.create(:user, :owner)}
    let(:admin) {FactoryGirl.create(:user, :admin)}
    let(:user_advertisement) {FactoryGirl.create(:advertisement, user: user)}
    let(:owner_advertisement) {FactoryGirl.create(:advertisement, user: owner)}
    let(:admin_advertisement) {FactoryGirl.create(:advertisement, user: admin)}

    it 'blocks anonymous users' do
      [user_advertisement, owner_advertisement, admin_advertisement].each do |ad_type|
        expect(subject).not_to permit(nil, ad_type)
      end
    end

    it 'allows registered users' do
      [user_advertisement, owner_advertisement, admin_advertisement].each do |ad_type|
        expect(subject).to permit(user, ad_type)
      end
    end

    it "allows owners" do
      [user_advertisement, owner_advertisement, admin_advertisement].each do |ad_type|
        expect(subject).to permit(owner, ad_type)
      end
    end

    it 'allows admins' do
      [user_advertisement, owner_advertisement, admin_advertisement].each do |ad_type|
        expect(subject).to permit(admin, ad_type)
      end
    end
  end

  permissions :create? do
    let(:user) {FactoryGirl.create(:user)}
    let(:owner) {FactoryGirl.create(:user, :owner)}
    let(:admin) {FactoryGirl.create(:user, :admin)}
    let(:user_advertisement) {FactoryGirl.create(:advertisement, user: user)}
    let(:owner_advertisement) {FactoryGirl.create(:advertisement, user: owner)}
    let(:admin_advertisement) {FactoryGirl.create(:advertisement, user: admin)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, user_advertisement)
    end

    it 'allows registered users' do
      expect(subject).to permit(user, user_advertisement)
    end

    it 'allows owners' do
      expect(subject).to permit(owner, owner_advertisement)
    end

    it 'allows admins' do
      expect(subject).to permit(admin, admin_advertisement)
    end
  end

  permissions :update? do
    let(:user) {FactoryGirl.create(:user)}
    let(:owner) {FactoryGirl.create(:user, :owner)}
    let(:admin) {FactoryGirl.create(:user, :admin)}
    let(:user_advertisement) {FactoryGirl.create(:advertisement, user: user)}
    let(:owner_advertisement) {FactoryGirl.create(:advertisement, user: owner)}
    let(:admin_advertisement) {FactoryGirl.create(:advertisement, user: admin)}

    it 'blocks anonymous users' do
      [user_advertisement, owner_advertisement, admin_advertisement].each do |ad_type|
        expect(subject).not_to permit(nil, ad_type)
      end
    end

    it 'allows registered users to update their own' do
      expect(subject).to permit(user, user_advertisement)
      expect(subject).not_to permit(user, owner_advertisement)
      expect(subject).not_to permit(user, admin_advertisement)
    end

    it 'allows owners to update their own' do
      expect(subject).not_to permit(owner, user_advertisement)
      expect(subject).to permit(owner, owner_advertisement)
      expect(subject).not_to permit(owner, admin_advertisement)
    end

    it 'allows admins to update any' do
      expect(subject).to permit(admin, user_advertisement)
      expect(subject).to permit(admin, owner_advertisement)
      expect(subject).to permit(admin, admin_advertisement)
    end
  end

  permissions :destroy? do
    let(:user) {FactoryGirl.create(:user)}
    let(:owner) {FactoryGirl.create(:user, :owner)}
    let(:admin) {FactoryGirl.create(:user, :admin)}
    let(:user_advertisement) {FactoryGirl.create(:advertisement, user: user)}
    let(:owner_advertisement) {FactoryGirl.create(:advertisement, user: owner)}
    let(:admin_advertisement) {FactoryGirl.create(:advertisement, user: admin)}

    it 'blocks anonymous users' do
      [user_advertisement, owner_advertisement, admin_advertisement].each do |ad_type|
        expect(subject).not_to permit(nil, ad_type)
      end
    end

    it 'allows registered users to destroy their own' do
      expect(subject).to permit(user, user_advertisement)
      expect(subject).not_to permit(user, owner_advertisement)
      expect(subject).not_to permit(user, admin_advertisement)
    end

    it 'allows owners to destroy their own' do
      expect(subject).not_to permit(owner, user_advertisement)
      expect(subject).to permit(owner, owner_advertisement)
      expect(subject).not_to permit(owner, admin_advertisement)
    end

    it 'allows admins to destroy any' do
      expect(subject).to permit(admin, user_advertisement)
      expect(subject).to permit(admin, owner_advertisement)
      expect(subject).to permit(admin, admin_advertisement)
    end
  end
end
