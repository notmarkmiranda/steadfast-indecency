# == Schema Information
#
# Table name: memberships
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(FALSE)
#  role       :integer          default("member")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pool_id    :bigint           not null
#  user_id    :bigint           not null
#
require "rails_helper"

RSpec.describe Membership, type: :model do
  it { should belong_to :pool }
  it { should belong_to :user }
end
