class Choice < ApplicationRecord
  belongs_to :option, optional: true
  belongs_to :question
  belongs_to :entry

  validates :question_id, uniqueness: { scope: :entry_id }
end
