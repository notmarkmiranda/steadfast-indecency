# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :pools, through: :memberships
  has_many :entries, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def self.with_points(pool_id)
    joins(:entries)
      .joins('LEFT JOIN choices ON choices.entry_id = entries.id')
      .where(entries: { pool_id: pool_id })
      .group('entries.id', 'users.id')
      .select('users.*')
      .select('entries.id AS entry_id')
      .select('SUM(CASE WHEN choices.correct = true THEN 1 ELSE 0 END) AS correct_choice_count')
      .select('SUM(CASE WHEN choices.correct = true OR choices.correct IS NULL THEN 1 ELSE 0 END) AS possible_points')
  end

  def super_duper_admin?
    email == "notmarkmiranda@gmail.com"
  end

  def has_no_memberships?
    memberships.count.zero?
  end

  def admin_of?(pool)
    membership = memberships.find_by(pool_id: pool.id)
    return false unless membership

    membership.admin? || membership.super_admin?
  end
end
