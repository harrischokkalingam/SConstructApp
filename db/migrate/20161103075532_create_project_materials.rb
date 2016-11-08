class CreateProjectMaterials < ActiveRecord::Migration
  def change
    create_table :project_materials do |t|
      t.integer :material_id
      t.integer :project_id
      t.timestamps null: false
    end
  end
end
