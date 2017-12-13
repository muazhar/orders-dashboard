class Order < ApplicationRecord
  validates_inclusion_of :state, in: %w( delivered pending ), message: "Invalid state"
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :by_state, ->(state) { where(state: state) if state }
end
