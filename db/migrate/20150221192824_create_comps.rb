class CreateComps < ActiveRecord::Migration
  def change
    create_table :comps do |t|
      t.string :name
      t.boolean :portrait
      t.integer :user_id
      t.attachment :image

      t.timestamps null: false
    end
  end
end
