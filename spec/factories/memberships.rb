FactoryBot.define do
  factory :membership do
    role { "member" }
    active { false }
    pool
    user
  end
end
