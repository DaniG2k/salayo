class ListingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    user.present?
  end

  def destroy?
    user.present? && (user.has_role?(:admin) || Listing.find_roles(:owner, user).present?)
  end
end
