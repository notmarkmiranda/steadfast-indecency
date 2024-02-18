class Choice < ApplicationRecord
  belongs_to :option
  delegate :question, to: :option
  belongs_to :entry
end
