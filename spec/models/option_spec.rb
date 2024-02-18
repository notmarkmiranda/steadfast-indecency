require "rails_helper"

RSpec.describe Option, type: :model do
  it { should belong_to :question }
  it { should have_many(:choices).dependent(:destroy) }
end
