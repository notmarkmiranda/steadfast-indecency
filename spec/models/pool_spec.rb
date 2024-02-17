require "rails_helper"

RSpec.describe Pool, type: :model do
  it { should have_many :memberships }
  it { should have_many(:users).through(:memberships) }
  it { should have_many :questions }
  it { should have_many :entries }
end
