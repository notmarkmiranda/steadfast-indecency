FactoryBot.define do
  factory :choice do
    question
    option
    entry
    correct { false }
  end
end
