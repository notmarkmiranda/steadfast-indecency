# == Schema Information
#
# Table name: choices
#
#  id          :bigint           not null, primary key
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  entry_id    :bigint           not null
#  option_id   :bigint
#  question_id :bigint           not null
#
require "rails_helper"

RSpec.describe Choice, type: :model do

  before do
    question = build(:question)
    question.save(validate: false)
    create(:choice, question: question, option: nil)
  end

  it { should belong_to(:option).optional }
  it { should belong_to :question }
  it { should belong_to :entry }
  it { should validate_uniqueness_of(:question_id).scoped_to(:entry_id) }
end
