class Membership < ApplicationRecord
  belongs_to :pool
  belongs_to :user

  enum role: {member: 0, admin: 1, super_admin: 2}
end
