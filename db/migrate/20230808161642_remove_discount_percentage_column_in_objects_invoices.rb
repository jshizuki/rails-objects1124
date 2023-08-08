class RemoveDiscountPercentageColumnInObjectsInvoices < ActiveRecord::Migration[7.0]
  def change
    remove_column :objects_invoices, :discount_percentage
  end
end
