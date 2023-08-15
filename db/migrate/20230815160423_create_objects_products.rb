class CreateObjectsProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :objects_products do |t|
      t.string :sku
      t.string :name
      t.integer :unit_price
      t.boolean :sold, default: false
      t.integer :quantity
      t.references :objects_invoice, foreign_key: true

      t.timestamps
    end
  end
end
