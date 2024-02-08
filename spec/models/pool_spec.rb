require "rails_helper"

RSpec.describe Pool, type: :model do
  it { should have_many :memberships }
  it { should have_many(:users).through(:memberships) }
end
