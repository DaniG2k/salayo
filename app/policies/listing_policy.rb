class ListingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.has_role?(:admin)

      scope.joins(:roles).where(roles: {user_id: user})
    end
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
