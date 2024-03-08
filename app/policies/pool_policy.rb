class PoolPolicy < ApplicationPolicy
  def show?
    user_is_member?
  end

  def admin?
    user_is_admin?
  end

  def create_entry?
    user_is_member? && record.is_in_the_future?
  end

  def edit_prop?
    user_is_admin? && record.editable?
  end

  def mark_as_paid?
    user_is_admin?
  end

  def mark_as_unpaid?
    user_is_admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  private

  def user_is_member?
    Membership.where(pool: record, user: user, active: true).exists?
  end

  def user_is_admin?
    Membership.find_by(pool: record, user: user, role: ["admin", "super_admin"]).present?
  end
end
