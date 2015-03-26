class AddSelectionsToExports < ActiveRecord::Migration
  def change
    add_column :exports, :selections, :text
  end
end
