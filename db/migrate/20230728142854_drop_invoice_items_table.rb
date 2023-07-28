class DropInvoiceItemsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :invoice_items
  end
end
