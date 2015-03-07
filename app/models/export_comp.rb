class ExportComp < ActiveRecord::Base
  belongs_to :export
  belongs_to :comp
end
