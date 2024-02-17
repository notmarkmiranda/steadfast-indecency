class PoolPolicy < ApplicationPolicy
  def show?
    Membership.where(pool: record, user: user).exists?
  end

  def admin?
    Membership.find_by(pool: record, user: user, role: ['admin', 'super_admin']).present?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
