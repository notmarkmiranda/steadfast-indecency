class Pool < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :questions

  def saved_questions
    questions.where.not(id: nil)
  end

  def create_super_admin(user_id)
    memberships.create(user_id: user_id, role: 2)
  end

  def allows_multiple_entries?
    multiple_entries
  end

  def superadmin
    memberships.find_by(role: 2)&.user
  end

  def is_in_the_future?
    cutoff_date > Date.today
  end
end
