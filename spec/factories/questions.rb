FactoryBot.define do
  factory :question do
    body { Faker::Lorem.question }
    tie_break { false }
    pool
  end
end
