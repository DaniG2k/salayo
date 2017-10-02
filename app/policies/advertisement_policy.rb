class AdvertisementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.present?
  end

  def create?
    destroy?
  end

  def new?
    show?
  end

  def update?
    destroy?
  end

  def edit?
    destroy?
  end

  def destroy?
    show? && (record.user == user || user.has_role?(:admin))
  end
end
