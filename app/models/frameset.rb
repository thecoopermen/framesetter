class Frameset < ActiveRecord::Base
  has_many :frames

  has_attached_file :icon

  validates_attachment :icon, content_type: { content_type: ['image/png'] }
end
