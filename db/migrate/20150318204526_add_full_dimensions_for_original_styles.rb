class AddFullDimensionsForOriginalStyles < ActiveRecord::Migration
  def change
    add_column :frames, :original_0_full_width, :integer
    add_column :frames, :original_0_full_height, :integer

    add_column :frames, :preview_0_full_width, :integer
    add_column :frames, :preview_0_full_height, :integer
  end
end
