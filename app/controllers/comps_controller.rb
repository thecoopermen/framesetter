class CompsController < ApplicationController

  def index
    @comps = current_user.comps.order(created_at: :desc)
  end

  def new
  end

  def create
    image = params[:comp][:image].first
    render status: 201, json: current_user.comps.create(image: image, name: image.original_filename)
  end

  def destroy
    render nothing: true, status: (current_user.comps.find(params[:id]).destroy ? 200 : 500)
  end

private

  def comp_params
    params.require(:comp).permit(:image, :name)
  end
end
