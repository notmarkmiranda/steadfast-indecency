FactoryBot.define do
  factory :membership do
    role { 1 }
    active { false }
    pool { nil }
    user { nil }
  end
end
