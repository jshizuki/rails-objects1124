class RenameDiscountToDiscountTypeInObjectsInvoices < ActiveRecord::Migration[7.0]
  def change
    rename_column :objects_invoices, :discount, :discount_type
  end
end
