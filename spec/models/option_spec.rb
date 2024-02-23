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
end
