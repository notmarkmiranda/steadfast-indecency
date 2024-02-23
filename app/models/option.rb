# == Schema Information
#
# Table name: options
#
#  id          :bigint           not null, primary key
#  body        :string
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#
class Option < ApplicationRecord
  belongs_to :question
  has_many :choices, dependent: :destroy
end
