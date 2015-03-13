class Frame < ActiveRecord::Base
  belongs_to :frameset

  has_attached_file :image, processors: [ :thumbnail, :transparency ], styles: {
    original_0: {},
    original_90: { convert_options: '-rotate 90' },
    original_180: { convert_options: '-rotate 180' },
    original_270: { convert_options: '-rotate 270' },
    preview_0: '550x400>',
    preview_90: { geometry: '550x400>', convert_options: '-rotate 90' },
    preview_180: { geometry: '550x400>', convert_options: '-rotate 180' },
    preview_270: { geometry: '550x400>', convert_options: '-rotate 270' },
    thumbnail: '64x64>'
  }

  validates_attachment :image, content_type: { content_type: ['image/png'] }
end
