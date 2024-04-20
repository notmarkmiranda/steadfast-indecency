# == Schema Information
#
# Table name: pools
#
#  id               :bigint           not null, primary key
#  cutoff_date      :datetime
#  description      :string
#  event_date       :datetime
#  multiple_entries :boolean          default(FALSE)
#  name             :string           not null
#  price            :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Pool < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :questions, dependent: :destroy
  has_many :entries, dependent: :destroy

  delegate :count, to: :questions, prefix: true

  def users_by_points
    users_with_points
      .select("RANK() OVER (ORDER BY SUM(CASE WHEN choices.correct = true THEN 1 ELSE 0 END) DESC, SUM(CASE WHEN choices.correct = true OR choices.correct IS NULL THEN 1 ELSE 0 END) DESC) AS rank")
      .order("correct_choice_count DESC", "possible_points DESC")
      .decorate
  end

  def users_by_possible_points
    users_with_points
      .select("RANK() OVER (ORDER BY SUM(CASE WHEN choices.correct = true OR choices.correct IS NULL THEN 1 ELSE 0 END) DESC, SUM(CASE WHEN choices.correct = true THEN 1 ELSE 0 END) DESC) AS rank")
      .order("possible_points DESC", "correct_choice_count DESC")
      .decorate
  end

  def entries_for_detailed_scoreboard
    Entry.where(pool: self)
      .joins(:user, :choices)
      .select("entries.*")
      .select("users.email")
      .select("COUNT(DISTINCT questions.id) AS total_questions")
      .select("COUNT(DISTINCT CASE WHEN choices.correct = true THEN choices.id END) AS correct_answers")
      .select("COUNT(DISTINCT CASE WHEN choices.correct = true OR choices.correct IS NULL THEN questions.id END) AS possible_answers")
      .select("RANK() OVER (ORDER BY COUNT(DISTINCT CASE WHEN choices.correct = true THEN choices.id END) DESC) AS rank")
      .joins("LEFT JOIN questions ON questions.pool_id = entries.pool_id")
      .joins("LEFT JOIN choices ON choices.entry_id = entries.id AND choices.question_id = questions.id")
      .group("entries.id", "users.email")
      .order("correct_answers DESC")
  end

  def saved_questions
    questions.where.not(id: nil)
  end

  def create_super_admin(user_id)
    memberships.create(user_id: user_id, role: 2, active: true)
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

  def entry_ineligible?(user)
    !entry_eligible?(user)
  end

  def is_in_the_future?
    cutoff_date > Time.zone.today
  end

  private

  def users_with_points
    User.with_points(id)
    # .joins(entries: :choices)
    # .select('users.*')
    # .select('SUM(CASE WHEN choices.correct = true THEN 1 ELSE 0 END) AS correct_choice_count')
    # .select('SUM(CASE WHEN choices.correct = true OR choices.correct IS NULL THEN 1 ELSE 0 END) AS possible_points')
    # .select('RANK() OVER (ORDER BY SUM(CASE WHEN choices.correct = true THEN 1 ELSE 0 END) DESC, SUM(CASE WHEN choices.correct = true OR choices.correct IS NULL THEN 1 ELSE 0 END) DESC) AS rank')
    # .where(entries: { pool_id: id })
    # .group('users.id')
    # .order('correct_choice_count DESC', 'possible_points DESC')
  end
end
