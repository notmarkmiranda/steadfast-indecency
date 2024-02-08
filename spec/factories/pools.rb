FactoryBot.define do
  factory :pool do
    name { Faker::GreekPhilosophers.name }
    cutoff_date { 1.week.from_now }
    event_date { 2.weeks.from_now }
    multiple_entries { false }
    description { Faker::GreekPhilosophers.quote }
  end
end
