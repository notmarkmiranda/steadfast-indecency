require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many :memberships }
  it { should have_many(:pools).through(:memberships) }
  it { should have_many :entries }
end
