class ExportsController < ApplicationController

  def index
  end

  def show
    @export = Export.find(params[:id])
  end

  def create
    @export = Export.create(export_params)
  end

  def update
    Export.find(params[:id]).update_attributes(export_params)
    render nothing: true, status: 200
  end

private

  def export_params
    params.require(:export).permit(:selections, export_comps_attributes: [ :comp_id ])
  end
end
