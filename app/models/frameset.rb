class Frameset < ActiveRecord::Base
  has_many :frames, dependent: :destroy

  has_attached_file :icon

  validates_attachment :icon, content_type: { content_type: ['image/png'] }
end
