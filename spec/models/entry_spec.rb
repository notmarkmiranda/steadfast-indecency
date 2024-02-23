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
require "rails_helper"

RSpec.describe Entry, type: :model do
  it { should belong_to(:pool) }
  it { should belong_to(:user) }
  it { should have_many(:choices).dependent(:destroy) }
end
