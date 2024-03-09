class MembershipPolicy < ApplicationPolicy
  def destroy?
    record.user == user || record.pool.superadmin == user
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
