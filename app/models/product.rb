class Product < ApplicationRecord
  belongs_to :invoice, optional: true

  # For displaying both sku and name in the form
  def sku_and_name
    "#{sku} - #{name}"
  end
end
