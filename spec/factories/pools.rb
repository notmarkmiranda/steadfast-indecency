# == Schema Information
#
# Table name: pools
#
#  id               :bigint           not null, primary key
#  cutoff_date      :datetime
#  description      :string
#  event_date       :datetime
#  multiple_entries :boolean          default(FALSE)
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :pool do
    name { Faker::GreekPhilosophers.name }
    cutoff_date { DateTime.tomorrow.at_midday }
    event_date { (DateTime.tomorrow + 1.week).at_midday }
    multiple_entries { false }
    description { Faker::GreekPhilosophers.quote }

    trait :with_questions do
      transient do
        question_count { 0 }
      end

      after(:create) do |pool, evaluator|
        create_list(:question, evaluator.question_count, :with_options, pool: pool)
      end
    end
  end
end
