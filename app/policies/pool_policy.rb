class PoolPolicy < ApplicationPolicy
  def show?
    user_is_member?
  end

  def admin?
    Membership.find_by(pool: record, user: user, role: ["admin", "super_admin"]).present?
  end

  def create_entry?
    user_is_member?
  end

  def mark_as_paid?
    admin?
  end

  def mark_as_unpaid?
    admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  private

  def user_is_member?
    Membership.where(pool: record, user: user).exists?
  end
end
