# == Schema Information
#
# Table name: pools
#
#  id               :bigint           not null, primary key
#  cutoff_date      :datetime
#  description      :string
#  event_date       :datetime
#  multiple_entries :boolean          default(FALSE)
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require "rails_helper"

RSpec.describe Pool, type: :model do
  it { should have_many :memberships }
  it { should have_many(:users).through(:memberships) }
  it { should have_many :questions }
  it { should have_many :entries }
end
