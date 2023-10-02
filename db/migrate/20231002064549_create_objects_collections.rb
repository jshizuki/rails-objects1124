class CreateObjectsCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :objects_collections do |t|
      t.string :name

      t.timestamps
    end
  end
end
