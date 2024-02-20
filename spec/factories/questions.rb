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
        question.save(validate: false)
        create_list(:option, evaluator.option_count, question: question)
      end
    end
  end
end
