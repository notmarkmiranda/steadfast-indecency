# == Schema Information
#
# Table name: entries
#
#  id         :bigint           not null, primary key
#  paid       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pool_id    :bigint           not null
#  user_id    :bigint           not null
#
FactoryBot.define do
  factory :entry do
    pool
    user
    paid { false }
  end
end
