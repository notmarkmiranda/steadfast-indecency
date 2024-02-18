class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :pools, through: :memberships
  has_many :entries, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def super_duper_admin?
    email == "notmarkmiranda@gmail.com"
  end

  def has_no_memberships?
    memberships.count.zero?
  end
end
