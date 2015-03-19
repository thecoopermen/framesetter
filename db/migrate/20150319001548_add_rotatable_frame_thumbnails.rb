class AddRotatableFrameThumbnails < ActiveRecord::Migration
  def change
    add_column :frames, :thumbnail_0_top, :integer
    add_column :frames, :thumbnail_0_left, :integer
    add_column :frames, :thumbnail_0_width, :integer
    add_column :frames, :thumbnail_0_height, :integer

    add_column :frames, :thumbnail_90_top, :integer
    add_column :frames, :thumbnail_90_left, :integer
    add_column :frames, :thumbnail_90_width, :integer
    add_column :frames, :thumbnail_90_height, :integer

    add_column :frames, :thumbnail_180_top, :integer
    add_column :frames, :thumbnail_180_left, :integer
    add_column :frames, :thumbnail_180_width, :integer
    add_column :frames, :thumbnail_180_height, :integer

    add_column :frames, :thumbnail_270_top, :integer
    add_column :frames, :thumbnail_270_left, :integer
    add_column :frames, :thumbnail_270_width, :integer
    add_column :frames, :thumbnail_270_height, :integer

    add_column :frames, :thumbnail_0_full_width, :integer
    add_column :frames, :thumbnail_0_full_height, :integer
  end
end
