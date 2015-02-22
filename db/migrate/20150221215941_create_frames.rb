class CreateFrames < ActiveRecord::Migration
  def change
    create_table :frames do |t|
      t.string :name
      t.attachment :image
      t.references :frameset

      t.timestamps null: false
    end
  end
end
