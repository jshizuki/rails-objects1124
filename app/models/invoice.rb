class Invoice < ApplicationRecord
  has_many :products

  validates_presence_of :order_date, :billed_to
end
