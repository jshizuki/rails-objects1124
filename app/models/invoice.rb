class Invoice < ApplicationRecord
  has_many :products
  accepts_nested_attributes_for :products

  validates_presence_of :order_date
end
