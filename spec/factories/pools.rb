FactoryBot.define do
  factory :pool do
    name { "MyString" }
    cutoff_date { "2024-02-07" }
    event_date { "2024-02-07" }
    multiple_entries { false }
    description { "MyString" }
  end
end
