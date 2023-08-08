class RenameDiscountAmountToDiscountInputInObjectsInvoices < ActiveRecord::Migration[7.0]
  def change
    rename_column :objects_invoices, :discount_amount, :discount_input
  end
end
