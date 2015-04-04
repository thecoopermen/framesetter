class AddScaleColumnsToFrames < ActiveRecord::Migration
  def change
    add_column :frames, :preview_0_scale, :float, default: 1.0
    add_column :frames, :preview_90_scale, :float, default: 1.0
    add_column :frames, :preview_180_scale, :float, default: 1.0
    add_column :frames, :preview_270_scale, :float, default: 1.0
  end
end
