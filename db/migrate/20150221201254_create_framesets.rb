class CreateFramesets < ActiveRecord::Migration
  def change
    create_table :framesets do |t|
      t.string :name
      t.attachment :icon

      t.timestamps null: false
    end
  end
end
