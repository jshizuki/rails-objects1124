class DropTables < ActiveRecord::Migration[7.0]
  def up
    drop_table :objects_products if table_exists?(:objects_products)
    drop_table :objects_invoices, if_exists: true, force: :cascade
  end
end
