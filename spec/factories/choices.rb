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
FactoryBot.define do
  factory :choice do
    question
    option
    entry
  end
end
