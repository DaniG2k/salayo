class ListingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    destroy?
  end

  def show?
    user.present?
  end

  def create?
    destroy?
  end

  def new?
    show? && (user.has_role?(:admin) || user.has_role?(:owner))
  end

  def update?
    destroy?
  end

  def edit?
    destroy?
  end

  def destroy?
    show? && (user.has_role?(:admin) || Listing.find_roles(:owner, user).present?)
  end
end
