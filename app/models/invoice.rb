class Invoice < ApplicationRecord
  has_many :products
  # accepts_nested_attributes_for :products

  validates_presence_of :order_date, :billed_to
  validates_numericality_of :shipping_fee, :discount, greater_than_or_equal_to: 0, allow_blank: true
end
