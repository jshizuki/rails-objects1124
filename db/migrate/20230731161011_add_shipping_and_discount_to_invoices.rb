class AddShippingAndDiscountToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :shipping_fee, :integer, default: 0
    add_column :invoices, :discount, :integer, default: 0
  end
end
