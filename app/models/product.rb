class Product < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :sku, :unit_price
end
