class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string  :name
      t.text    :description
      t.integer :quantity
      t.string  :unit
      t.string  :dimensions
      t.timestamps null: false
    end
  end
end
