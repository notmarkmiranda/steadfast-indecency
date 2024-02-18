require "rails_helper"

RSpec.describe Question, type: :model do
  it { should belong_to :pool }
  it { should have_many :options }

  describe "validations" do
    let(:question) { build(:question) }

    it "requires at least two options" do
      question.valid?

      expect(question.errors[:options]).to include("must have at least two")
      expect(question.save).to be false
    end

    it "saves with at least two options" do
      question.options << [build(:option), build(:option)]

      expect(question.save).to be true
    end
  end
end
