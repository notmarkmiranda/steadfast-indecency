FactoryBot.define do
  factory :option do
    body { Faker::Lorem.sentence }
    correct { nil }
    question
  end
end
