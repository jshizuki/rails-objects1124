class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.date :order_date
      t.string :billed_to

      t.timestamps
    end
  end
end
