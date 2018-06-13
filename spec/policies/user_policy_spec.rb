require 'rails_helper'

RSpec.describe UserPolicy do
  let(:user) { User.new }

  subject { described_class }

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end

  permissions :show? do
    let(:user)  { create(:user) }
    let(:owner) { create(:user, :owner) }
    let(:admin) { create(:user, :admin) }

    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, user)
    end

    it 'allows regular users' do
      expect(subject).to permit(user, user)
      expect(subject).not_to permit(user, owner)
      expect(subject).not_to permit(user, admin)
    end

    it 'allows owners' do
      expect(subject).not_to permit(owner, user)
      expect(subject).to permit(owner, owner)
      expect(subject).not_to permit(owner, admin)
    end

    it 'allows admins' do
      expect(subject).to permit(admin, user)
      expect(subject).to permit(admin, owner)
      expect(subject).to permit(admin, admin)
    end
  end

  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
  #
  # permissions :update? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
  #
  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end
