class Entry < ApplicationRecord
  belongs_to :pool
  belongs_to :user
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices
end
