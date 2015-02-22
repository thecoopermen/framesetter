class Frame < ActiveRecord::Base
  belongs_to :frameset

  has_attached_file :image, styles: { original: {} }, processors: [ :transparency ]

  validates_attachment :image, content_type: { content_type: ['image/png'] }
end
