FactoryBot.define do
  factory :pool do
    name { Faker::GreekPhilosophers.name }
    cutoff_date { 1.week.from_now }
    event_date { 2.weeks.from_now }
    multiple_entries { false }
    description { Faker::GreekPhilosophers.quote }

    trait :with_questions do
      transient do
        question_count { 0 }
      end

      after(:create) do |pool,evaluator|
        create_list(:question, evaluator.question_count, :with_options, pool: pool)
      end
    end
  end
end
