class Comp < ActiveRecord::Base
  has_many :export_comps
  has_many :exports, through: :export_comps

  has_attached_file :image, styles: { thumbnail: '400x400>' }

  validates_attachment :image, content_type: { content_type: ['image/png'] }

  def landscape?
    !portrait?
  end
end
