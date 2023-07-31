class AddInvoiceNumberToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :invoice_number, :integer, default: 10_000
  end
end
