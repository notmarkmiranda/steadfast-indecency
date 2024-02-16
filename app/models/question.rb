class Question < ApplicationRecord
  belongs_to :pool
  has_many :options
  accepts_nested_attributes_for :options, allow_destroy: true

  validate :require_two_options

  private

  def require_two_options
    errors.add(:options, 'must have at least two') if options.size < 2
  end
end
