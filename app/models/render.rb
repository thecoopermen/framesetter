class Render < ActiveRecord::Base
  belongs_to :export
  belongs_to :comp
  belongs_to :frame

  has_attached_file :image
  validates_attachment :image, content_type: { content_type: /^image\/.*$/ }
end
