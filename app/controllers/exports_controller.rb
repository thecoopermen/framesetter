class ExportsController < ApplicationController

  def index
  end

  def show
    @export = current_user.exports.find(params[:id])
  end

  def create
    @export = current_user.exports.create(export_params)
  end

  def update
    current_user.exports.find(params[:id]).update_attributes(export_params)
    render nothing: true, status: 200
  end

private

  def export_params
    params.require(:export).permit(:selections, export_comps_attributes: [ :comp_id ])
  end
end
