class Product < ApplicationRecord
  belongs_to :invoice, optional: true

  # validates_presence_of :sku, :unit_price
end
