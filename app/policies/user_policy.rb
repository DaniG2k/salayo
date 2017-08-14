class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    return false if user.nil?
    user.has_role?(:admin) || record.id == user.id
  end
end
