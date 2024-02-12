class Membership < ApplicationRecord
  attribute :email
  belongs_to :pool
  belongs_to :user

  enum role: {member: 0, admin: 1, super_admin: 2}

  def accept!
    update(active: true)
  end

  def invitation_token
    to_sgid(for: "membership").to_s
  end
end
