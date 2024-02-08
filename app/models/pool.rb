class Pool < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  def create_super_admin(user_id)
    memberships.create(user_id: user_id, role: 2)
  end

  def allows_multiple_entries?
    multiple_entries
  end
end
