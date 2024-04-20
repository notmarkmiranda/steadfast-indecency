# == Schema Information
#
# Table name: entries
#
#  id         :bigint           not null, primary key
#  paid       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pool_id    :bigint           not null
#  user_id    :bigint           not null
#
class Entry < ApplicationRecord
  belongs_to :pool
  belongs_to :user
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices

  delegate :questions, to: :pool, prefix: true

  def paid!
    update!(paid: true)
  end

  def unpaid!
    update!(paid: false)
  end

  def choice_for_question(question)
    choices.find_by(question: question)
  end
end
