class ObjectsProduct < ApplicationRecord
  # self.table_name = 'objects_products'
  belongs_to :objects_invoice, optional: true
  belongs_to :objects_collection, optional: true
  has_one_attached :photo
  # , foreign_key: 'objects_invoice_id'
  acts_as_favoritable

  # For displaying sku, name and price in the form
  def sku_name_and_price
    "#{sku} - #{name} - $#{unit_price}"
  end
end
