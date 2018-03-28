require 'rails_helper'

RSpec.describe ListingPolicy do

  let(:user) { User.new }

  subject { described_class }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  permissions 'policy_scope' do
    subject { Pundit.policy_scope(user, Listing) }

    let(:user) {create(:user, :owner)}
    let(:listing) {create(:listing, owner: user)}

    it 'is empty for anonymous users' do
      expect(Pundit.policy_scope(nil, Listing)).to be_empty
    end

    it 'includes listings a user is allowed to view' do
      expect(subject).to include(listing)
    end

    it 'returns all listings for admins' do
      user.update_attribute :role, :admin
      expect(subject).to include(listing)
    end
  end

  permissions :show? do
    let(:regular_user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:user1) { create(:user, :owner) }
    let(:user2) { create(:user, :owner) }
    let(:listing1) { create(:listing, owner: user1) }
    let(:listing2) { create(:listing, owner: user2) }

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing1)
    end

    it 'allows registered users' do
      expect(subject).to permit(regular_user, listing1)
    end

    it "allows owner who doesn't own the listing" do
      expect(subject).to permit(user1, listing2)
    end

    it 'allows listing owner' do
      expect(subject).to permit(user1, listing1)
    end

    it 'allows admins' do
      expect(subject).to permit(admin, listing2)
    end
  end

  permissions :create? do
    let(:regular_user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:user1) { create(:user, :owner) }
    let(:user2) { create(:user, :owner) }
    let(:listing1) { create(:listing, owner: user1) }
    let(:listing2) { create(:listing, owner: user2) }

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing1)
    end

    it 'blocks registered users' do
      expect(subject).not_to permit(regular_user, listing1)
    end

    it "blocks owner who doesn't own the listing" do
      expect(subject).not_to permit(user1, listing2)
    end

    it 'allows listing owner' do
      expect(subject).to permit(user1, listing1)
    end

    it 'allows admins' do
      expect(subject).to permit(admin, listing2)
    end
  end

  permissions :update? do
    let(:regular_user) { create(:user) }
    let(:admin) { create(:user, :admin) }
    let(:user1) { create(:user, :owner) }
    let(:user2) { create(:user, :owner) }
    let(:listing1) { create(:listing, owner: user1) }
    let(:listing2) { create(:listing, owner: user2) }

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing1)
    end

    it 'blocks registered users' do
      expect(subject).not_to permit(regular_user, listing1)
    end

    it "blocks owner who doesn't own the listing" do
      expect(subject).not_to permit(user1, listing2)
    end

    it 'allows listing owner' do
      expect(subject).to permit(user1, listing1)
    end

    it 'allows admins' do
      expect(subject).to permit(admin, listing2)
    end
  end

  permissions :destroy? do
    let(:admin) { create(:user, :admin) }
    let(:user1) { create(:user, :owner) }
    let(:user2) { create(:user, :owner) }
    let(:listing1) { create(:listing, owner: user1) }
    let(:listing2) { create(:listing, owner: user2) }

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, listing1)
    end

    it "blocks owner who doesn't own the listing" do
      expect(subject).not_to permit(user1, listing2)
    end

    it 'allows listing owner' do
      expect(subject).to permit(user1, listing1)
    end

    it 'allows admins' do
      expect(subject).to permit(admin, listing1)
    end
  end
end
