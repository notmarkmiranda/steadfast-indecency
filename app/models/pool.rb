class Pool < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :questions, dependent: :destroy
  has_many :entries, dependent: :destroy

  delegate :count, to: :questions, prefix: true

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

  def editable?
    is_in_the_future? && entries.empty?
  end

  def single_entry?
    !multiple_entries
  end

  def entry_eligible?(user)
    multiple_entries? || !entries.where(user: user).any?
  end

  private

  def is_in_the_future?
    cutoff_date > Time.zone.today
  end
end
