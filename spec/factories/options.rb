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
FactoryBot.define do
  factory :option do
    body { Faker::Lorem.sentence }
    correct { nil }
    question
  end
end
