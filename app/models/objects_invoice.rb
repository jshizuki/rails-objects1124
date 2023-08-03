class ObjectsInvoice < ApplicationRecord
  # self.table_name = 'objects_invoices'
  has_many :objects_products
  # , foreign_key: 'objects_invoice_id'
  # accepts_nested_attributes_for :products

  validates_presence_of :order_date, :billed_to
  validates_numericality_of :shipping_fee, :discount, greater_than_or_equal_to: 0, allow_blank: false
end
