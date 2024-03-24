# == Schema Information
#
# Table name: choices
#
#  id          :bigint           not null, primary key
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  entry_id    :bigint           not null
#  option_id   :bigint
#  question_id :bigint           not null
#
class Choice < ApplicationRecord
  include CorrectHelper

  belongs_to :option, optional: true
  belongs_to :question
  belongs_to :entry

  delegate :body, to: :question, prefix: true
  delegate :options, to: :question, prefix: true

  validates :question_id, uniqueness: {scope: :entry_id}

  scope :in_question_order, -> { joins(:question).order("questions.created_at") }
end
