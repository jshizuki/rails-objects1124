class RemoveDefaultFromDiscountTypeInObjectsInvoices < ActiveRecord::Migration[7.0]
  def change
    change_column_default :objects_invoices, :discount_type, nil
  end
end
