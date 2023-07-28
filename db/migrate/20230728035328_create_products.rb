class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.integer :stock
      t.integer :unit_price

      t.timestamps
    end
  end
end
