FactoryBot.define do
  factory :membership do
    role { 0 }
    active { false }
    pool
    user
  end
end
