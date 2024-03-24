# == Schema Information
#
# Table name: options
#
#  id          :bigint           not null, primary key
#  body        :string
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#
require "rails_helper"

RSpec.describe Option, type: :model do
  it { should belong_to :question }
  it { should have_many(:choices).dependent(:destroy) }

  context "#siblings" do
    let(:question) { create(:question, :with_options) }
    let(:option_a) { question.options.first }
    let(:option_b) { question.options.last }
    let(:option_c) { create(:question, :with_options).options.first }

    it "can retrieve its siblings" do
      expect(option_a.siblings).to eq([option_b])
      expect(option_b.siblings).to eq([option_a])
    end

    it "does not include non-siblings" do
      expect(option_a.siblings).not_to include(option_c)
      expect(option_b.siblings).not_to include(option_c)
    end
  end
end
