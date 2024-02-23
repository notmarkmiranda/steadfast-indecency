class Choice < ApplicationRecord
  belongs_to :option, optional: true
  belongs_to :question
  belongs_to :entry

  delegate :body, to: :question, prefix: true
  delegate :options, to: :question, prefix: true

  validates :question_id, uniqueness: { scope: :entry_id }
end
