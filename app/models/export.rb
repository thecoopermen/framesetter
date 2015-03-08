class Export < ActiveRecord::Base
  belongs_to :user
  has_many :export_comps
  has_many :comps, through: :export_comps

  accepts_nested_attributes_for :export_comps
end
