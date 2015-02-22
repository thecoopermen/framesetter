class Admin::FramesController < Admin::ApplicationController

  def index
    @frames = frameset.frames
  end

  def new
    @frame = frameset.frames.build
  end

  def create
    @frame = frameset.frames.build(frame_params)
    if @frame.save
      redirect_to admin_frameset_frames_path(frameset), notice: 'Frame successfully created'
    else
      render :new
    end
  end

  def edit
    # @frameset = Frameset.find(params[:id])
  end

  def update
    # frameset = Frameset.find(params[:id])
    # if frameset.update_attributes(frameset_params)
    #   redirect_to admin_framesets_path, notice: 'Frameset successfully updated'
    # else
    #   render :new
    # end
  end

  def destroy
    # frameset = Frameset.find(params[:id])
    # if frameset.destroy
    #   redirect_to admin_framesets_path, notice: 'Frameset deleted successfully'
    # else
    #   redirect_to admin_framesets_path, alert: 'Frameset could not be deleted. Try again later.'
    # end
  end

private

  def frame_params
    params.require(:frame).permit(:name, :image)
  end

  def frameset
    @frameset ||= Frameset.find(params[:frameset_id])
  end
end
