require 'rails_helper'

RSpec.describe ListingPolicy do

  let(:user) { User.new }

  subject { described_class }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  permissions 'policy_scope' do
    subject { Pundit.policy_scope(user, Listing) }

    let(:user) {FactoryGirl.create(:user)}
    let(:listing) {FactoryGirl.create(:listing, owner: user)}

    it 'is empty for anonymous users' do
      expect(Pundit.policy_scope(nil, Listing)).to be_empty
    end

    it 'includes listings a user is allowed to view' do
      assign_role!(user, :owner, listing)
      expect(subject).to include(listing)
    end

    it 'returns all listings for admins' do
      assign_role!(user, :admin)
      expect(subject).to include(listing)
    end
  end

  permissions :show? do
    let(:regular_user) {FactoryGirl.create(:user)}
    let(:user1) {FactoryGirl.create(:user)}
    let(:user2) {FactoryGirl.create(:user)}
    let(:listing1) {FactoryGirl.create(:listing, owner: user1)}
    let(:listing2) {FactoryGirl.create(:listing, owner: user2)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing1)
    end

    it 'allows registered users' do
      expect(subject).to permit(regular_user, listing1)
    end

    it "allows owner who doesn't own the listing" do
      assign_role!(user1, :owner, listing1)
      assign_role!(user2, :owner, listing2)
      expect(subject).to permit(user1, listing2)
    end

    it 'allows listing owner' do
      assign_role!(user1, :owner, listing1)
      expect(subject).to permit(user1, listing1)
    end

    it 'allows admins' do
      assign_role!(user1, :admin)
      expect(subject).to permit(user1, listing2)
    end
  end

  permissions :create? do
    let(:regular_user) {FactoryGirl.create(:user)}
    let(:user1) {FactoryGirl.create(:user)}
    let(:user2) {FactoryGirl.create(:user)}
    let(:listing1) {FactoryGirl.create(:listing, owner: user1)}
    let(:listing2) {FactoryGirl.create(:listing, owner: user2)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing1)
    end

    it 'blocks registered users' do
      expect(subject).not_to permit(regular_user, listing1)
    end

    it "blocks owner who doesn't own the listing" do
      assign_role!(user1, :owner, listing1)
      assign_role!(user2, :owner, listing2)
      expect(subject).not_to permit(user1, listing2)
    end

    it 'allows listing owner' do
      assign_role!(user1, :owner, listing1)
      expect(subject).to permit(user1, listing1)
    end

    it 'allows admins' do
      assign_role!(user1, :admin)
      expect(subject).to permit(user1, listing2)
    end
  end
  #
  # permissions :update? do
  #   let(:user) {FactoryGirl.create(:user)}
  #   let(:listing) {FactoryGirl.create(:listing)}
  #
  #   it 'blocks anonymous users' do
  #     expect(subject).not_to permit(nil, listing)
  #   end
  #
  #   it 'blocks registered users' do
  #     expect(subject).not_to permit(user, listing)
  #   end
  #
  #   it "blocks owner who doesn't own the listing" do
  #     assign_role!(user, :owner)
  #     expect(subject).not_to permit(user, listing)
  #   end
  #
  #   it 'allows listing owner' do
  #     assign_role!(user, :owner, listing)
  #     expect(subject).to permit(user, listing)
  #   end
  #
  #   it 'allows admins' do
  #     assign_role!(user, :admin)
  #     expect(subject).to permit(user, listing)
  #   end
  # end

  permissions :destroy? do
    let(:user1) {FactoryGirl.create(:user)}
    let(:user2) {FactoryGirl.create(:user)}
    let(:listing1) {FactoryGirl.create(:listing, owner: user1)}
    let(:listing2) {FactoryGirl.create(:listing, owner: user2)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing1)
    end

    it "blocks owner who doesn't own the listing" do
      assign_role!(user1, :owner, listing1)
      assign_role!(user2, :owner, listing2)
      expect(subject).not_to permit(user1, listing2)
    end

    it 'allows listing owner' do
      assign_role!(user1, :owner, listing1)
      expect(subject).to permit(user1, listing1)
    end

    it 'allows admins' do
      assign_role!(user2, :admin)
      expect(subject).to permit(user2, listing1)
    end
  end
end
