class AddDimensionsToFrames < ActiveRecord::Migration
  def change
    add_column :frames, :top, :integer
    add_column :frames, :left, :integer
    add_column :frames, :width, :integer
    add_column :frames, :height, :integer
  end
end
