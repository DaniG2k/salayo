class ListingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?

      scope.where(owner: user)
    end
  end

  def show?
    user.present?
  end

  def create?
    destroy?
  end

  def new?
    show? && (user.admin? || user.owner?)
  end

  def update?
    destroy?
  end

  def edit?
    destroy?
  end

  def destroy?
    show? && (user.admin? || (record.owner == user))
  end
end
