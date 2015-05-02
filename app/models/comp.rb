class Comp < ActiveRecord::Base
  has_many :renders, dependent: :nullify
  has_many :export_comps, dependent: :nullify
  has_many :exports, through: :export_comps

  has_attached_file :image, styles: { thumbnail: '400x400' }

  validates_attachment :image, content_type: { content_type: /^image\/.*$/ }

  def landscape?
    !portrait?
  end
end
