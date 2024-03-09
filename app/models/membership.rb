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
class Membership < ApplicationRecord
  belongs_to :pool
  belongs_to :user
  delegate :entries, to: :pool, prefix: true

  delegate :entries, to: :user, prefix: true
  delegate :email, to: :user, prefix: true

  enum role: {member: 0, admin: 1, super_admin: 2}

  scope :pending, -> { where(active: false) }

  def accept!
    update(active: true)
  end

  def invitation_token
    to_sgid(for: "membership").to_s
  end

  def is_not_user?(object_user)
    user != object_user
  end
end
