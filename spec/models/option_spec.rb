require 'rails_helper'

RSpec.describe Option, type: :model do
  it { should belong_to :question }
end
