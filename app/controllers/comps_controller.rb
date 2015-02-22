class CompsController < ApplicationController

  def index
  end

  def new
  end

  def create
    image = params[:comp][:image].first
    render status: 201, json: Comp.create(image: image, name: image.original_filename)
  end

  def destroy
    redirect_to :index
  end

private

  def comp_params
    params.require(:comp).permit(:image, :name)
  end
end
