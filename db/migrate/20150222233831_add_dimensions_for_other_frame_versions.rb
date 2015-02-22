class AddDimensionsForOtherFrameVersions < ActiveRecord::Migration
  def change
    add_column :frames, :original_0_top, :integer
    add_column :frames, :original_0_left, :integer
    add_column :frames, :original_0_width, :integer
    add_column :frames, :original_0_height, :integer

    add_column :frames, :original_90_top, :integer
    add_column :frames, :original_90_left, :integer
    add_column :frames, :original_90_width, :integer
    add_column :frames, :original_90_height, :integer

    add_column :frames, :original_180_top, :integer
    add_column :frames, :original_180_left, :integer
    add_column :frames, :original_180_width, :integer
    add_column :frames, :original_180_height, :integer

    add_column :frames, :original_270_top, :integer
    add_column :frames, :original_270_left, :integer
    add_column :frames, :original_270_width, :integer
    add_column :frames, :original_270_height, :integer

    add_column :frames, :preview_0_top, :integer
    add_column :frames, :preview_0_left, :integer
    add_column :frames, :preview_0_width, :integer
    add_column :frames, :preview_0_height, :integer

    add_column :frames, :preview_90_top, :integer
    add_column :frames, :preview_90_left, :integer
    add_column :frames, :preview_90_width, :integer
    add_column :frames, :preview_90_height, :integer

    add_column :frames, :preview_180_top, :integer
    add_column :frames, :preview_180_left, :integer
    add_column :frames, :preview_180_width, :integer
    add_column :frames, :preview_180_height, :integer

    add_column :frames, :preview_270_top, :integer
    add_column :frames, :preview_270_left, :integer
    add_column :frames, :preview_270_width, :integer
    add_column :frames, :preview_270_height, :integer
  end
end
