class Export < ActiveRecord::Base
  belongs_to :user
  has_many :export_comps
  has_many :comps, through: :export_comps
  has_many :renders

  accepts_nested_attributes_for :export_comps

  after_commit :render_comps

private

  def render_comps
    RenderCompsWorker.perform_async(self.id) if previous_changes.keys.include?("selections")
  end
end
