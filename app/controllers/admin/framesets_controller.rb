class Admin::FramesetsController < Admin::ApplicationController

  def index
    @framesets = Frameset.order(created_at: :desc)
  end

  def new
    @frameset = Frameset.new
  end

  def create
    frameset = Frameset.new(frameset_params)
    if frameset.save
      redirect_to admin_framesets_path, notice: 'Frameset successfully created'
    else
      render :new
    end
  end

  def edit
    @frameset = Frameset.find(params[:id])
  end

  def update
    frameset = Frameset.find(params[:id])
    if frameset.update_attributes(frameset_params)
      redirect_to admin_framesets_path, notice: 'Frameset successfully updated'
    else
      render :new
    end
  end

  def destroy
    frameset = Frameset.find(params[:id])
    if frameset.destroy
      redirect_to admin_framesets_path, notice: 'Frameset deleted successfully'
    else
      redirect_to admin_framesets_path, alert: 'Frameset could not be deleted. Try again later.'
    end
  end

private

  def frameset_params
    params.require(:frameset).permit(:name, :icon)
  end
end
