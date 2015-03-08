class ExportsController < ApplicationController

  def index
  end

  def show
    @export = Export.find(params[:id])
  end

  def create
    @export = Export.create(export_params)
  end

private

  def export_params
    params.require(:export).permit(export_comps_attributes: [ :comp_id ])
  end
end
