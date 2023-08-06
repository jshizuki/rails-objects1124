class ObjectsInvoice < ApplicationRecord
  # self.table_name = 'objects_invoices'
  has_many :objects_products
  # , foreign_key: 'objects_invoice_id'

  validates_presence_of :order_date, :billed_to, allow_blank: true
  validates_numericality_of :shipping_fee, :discount_amount, :discount_percentage, greater_than_or_equal_to: 0, allow_blank: true
end
