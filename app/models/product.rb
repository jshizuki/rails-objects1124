class Product < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :sku, presence: true
  validates :unit_price, presence: true
end
