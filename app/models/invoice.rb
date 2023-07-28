class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :products, through: :invoice_items

  validates :order_date, presence: true
  validates :billed_to, presence: true
end
