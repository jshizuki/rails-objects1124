class CreateObjectsSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :objects_series do |t|
      t.string :name

      t.timestamps
    end
  end
end
