require 'rails_helper'

RSpec.describe ListingPolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
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
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
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
