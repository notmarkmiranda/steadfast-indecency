# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  body       :string
#  tie_break  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pool_id    :bigint           not null
#
class Question < ApplicationRecord
  belongs_to :pool
  has_many :options, dependent: :destroy
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true

  validate :require_two_options

  def first_option
    options.first
  end

  def last_option
    options.last
  end

  private

  def require_two_options
    errors.add(:options, "must have at least two") if options.size < 2
  end
end
