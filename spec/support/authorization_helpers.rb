module AuthorizationHelpers
  def assign_role!(user, role, obj=nil)
    if obj.nil?
      user.add_role(role)
    else
      user.add_role(role, obj)
    end
  end
end

RSpec.configure do |conf|
  conf.include AuthorizationHelpers
end
