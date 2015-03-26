class CreateRenders < ActiveRecord::Migration
  def change
    create_table :renders do |t|
      t.references :export, index: true
      t.references :comp, index: true
      t.references :frame, index: true
      t.integer :rotation
      t.integer :offset
      t.attachment :image

      t.timestamps null: false
    end
    add_foreign_key :renders, :exports
    add_foreign_key :renders, :comps
    add_foreign_key :renders, :frames
  end
end
