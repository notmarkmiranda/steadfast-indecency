require "rails_helper"

RSpec.describe OptionUpdaterService do
  let(:question) { create(:question, :with_options) }
  let(:option_a) { question.options.first }
  let(:option_b) { question.options.last }

  subject(:service_call) { described_class.call(option_a.id) }

  it "marks the option as correct" do
    expect { service_call }.to change { option_a.reload.correct }.from(nil).to(true)
  end

  it "marks the sibling option as incorrect" do
    expect { service_call }.to change { option_b.reload.correct }.from(nil).to(false)
  end

  describe "with choices" do
    let!(:choice_a) { create(:choice, option: option_a, question: question) }
    let!(:choice_b) { create(:choice, option: option_b, question: question) }

    it "marks the option's choices as correct" do
      expect { service_call }.to change { choice_a.reload.correct }.from(nil).to(true)
    end

    it "marks the option's sibling choices as incorrect" do
      expect { service_call}.to change { choice_b.reload.correct }.from(nil).to(false)
    end
  end
end