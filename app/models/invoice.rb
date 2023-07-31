class Invoice < ApplicationRecord
  has_many :products
  accepts_nested_attributes_for :products

  validates_presence_of :order_date

  Invoice.maximum(:invoice_number) || 10_000
end
