FactoryBot.define do
  factory :entry do
    pool
    user
    paid { false }
  end
end
