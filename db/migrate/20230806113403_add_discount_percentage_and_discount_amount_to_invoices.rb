class AddDiscountPercentageAndDiscountAmountToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :objects_invoices, :discount_percentage, :integer, default: 0
    add_column :objects_invoices, :discount_amount, :integer, default: 0
  end
end
