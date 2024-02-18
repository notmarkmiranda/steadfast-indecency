require "rails_helper"

RSpec.describe Entry, type: :model do
  it { should belong_to(:pool) }
  it { should belong_to(:user) }
  it { should have_many(:choices).dependent(:destroy) }
end
