class CreateExportComps < ActiveRecord::Migration
  def change
    create_table :export_comps do |t|
      t.references :export, index: true
      t.references :comp, index: true

      t.timestamps null: false
    end
    add_foreign_key :export_comps, :exports
    add_foreign_key :export_comps, :comps
  end
end
