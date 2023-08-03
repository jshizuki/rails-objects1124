class ObjectsProduct < ApplicationRecord
  # self.table_name = 'objects_products'
  belongs_to :objects_invoice, optional: true
  # , foreign_key: 'objects_invoice_id'

  # For displaying both sku and name in the form
  def sku_and_name
    "#{sku} - #{name}"
  end
end
