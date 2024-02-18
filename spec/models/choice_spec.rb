require 'rails_helper'

RSpec.describe Choice, type: :model do
  it { should belong_to :option }
  it { should delegate_method(:question).to(:option) }
  it { should belong_to :entry }
end
