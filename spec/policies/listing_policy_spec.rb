require 'rails_helper'

RSpec.describe ListingPolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions 'policy_scope' do
    subject { Pundit.policy_scope(user, Listing) }

    let!(:listing) {FactoryGirl.create(:listing)}
    let(:user) {FactoryGirl.create(:user)}

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
    let(:user) {FactoryGirl.create(:user)}
    let(:listing) {FactoryGirl.create(:listing)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing)
    end

    it 'allows registered users' do
      expect(subject).to permit(user, listing)
    end

    it "allows owner who doesn't own the listing" do
      assign_role!(user, :owner)
      expect(subject).to permit(user, listing)
    end

    it 'allows listing owner' do
      assign_role!(user, :owner, listing)
      expect(subject).to permit(user, listing)
    end

    it 'allows admins' do
      assign_role!(user, :admin)
      expect(subject).to permit(user, listing)
    end
  end

  permissions :create? do
    let(:user) {FactoryGirl.create(:user)}
    let(:listing) {FactoryGirl.create(:listing)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing)
    end

    it 'blocks registered users' do
      expect(subject).not_to permit(user, listing)
    end

    it "blocks owner who doesn't own the listing" do
      assign_role!(user, :owner)
      expect(subject).not_to permit(user, listing)
    end

    it 'allows listing owner' do
      assign_role!(user, :owner, listing)
      expect(subject).to permit(user, listing)
    end

    it 'allows admins' do
      assign_role!(user, :admin)
      expect(subject).to permit(user, listing)
    end
  end

  permissions :update? do
    let(:user) {FactoryGirl.create(:user)}
    let(:listing) {FactoryGirl.create(:listing)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing)
    end

    it 'blocks registered users' do
      expect(subject).not_to permit(user, listing)
    end

    it "blocks owner who doesn't own the listing" do
      assign_role!(user, :owner)
      expect(subject).not_to permit(user, listing)
    end

    it 'allows listing owner' do
      assign_role!(user, :owner, listing)
      expect(subject).to permit(user, listing)
    end

    it 'allows admins' do
      assign_role!(user, :admin)
      expect(subject).to permit(user, listing)
    end
  end

  permissions :destroy? do
    let(:user) {FactoryGirl.create(:user)}
    let(:listing) {FactoryGirl.create(:listing)}

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing)
    end

    it 'blocks registered users' do
      expect(subject).not_to permit(user, listing)
    end

    it "blocks owner who doesn't own the listing" do
      assign_role!(user, :owner)
      expect(subject).not_to permit(user, listing)
    end

    it 'allows listing owner' do
      assign_role!(user, :owner, listing)
      expect(subject).to permit(user, listing)
    end

    it 'allows admins' do
      assign_role!(user, :admin)
      expect(subject).to permit(user, listing)
    end
  end
end
