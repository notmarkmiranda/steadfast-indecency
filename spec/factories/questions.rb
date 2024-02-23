# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  body       :string
#  tie_break  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pool_id    :bigint           not null
#
FactoryBot.define do
  factory :question do
    body { Faker::Lorem.question }
    tie_break { false }
    pool

    trait :with_options do
      transient do
        option_count { 2 }
      end

      after(:build) do |question, evaluator|
        question.save!(validate: false)
        create_list(:option, evaluator.option_count, question: question)
      end
    end
  end
end
