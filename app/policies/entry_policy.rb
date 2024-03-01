class EntryPolicy < ApplicationPolicy
  def destroy?
    pool = record.pool
    (record.user == user || user.admin_of?(pool)) && pool.is_in_the_future?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
