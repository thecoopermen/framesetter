class CreateExports < ActiveRecord::Migration
  def change
    create_table :exports do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :exports, :users
  end
end
