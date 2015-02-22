class Comp < ActiveRecord::Base
  has_attached_file :image

  validates_attachment :image, content_type: { content_type: ['image/png'] }

  def landscape?
    !portrait?
  end
end
