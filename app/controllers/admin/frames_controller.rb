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
    @frame = frameset.frames.find(params[:id])
  end

  def update
    @frame = frameset.frames.find(params[:id])
    if @frame.update_attributes(frame_params)
      redirect_to admin_frameset_frames_path(frameset), notice: 'Frame successfully updated'
    else
      render :new
    end
  end

  def destroy
    frame = frameset.frames.find(params[:id])
    if frame.destroy
      redirect_to admin_frameset_frames_path(frameset), notice: 'Frame deleted successfully'
    else
      redirect_to admin_frameset_frames_path(frameset), alert: 'Frame could not be deleted. Try again later.'
    end
  end

private

  def frame_params
    params.require(:frame).permit(:name, :image, :left, :top, :width, :height)
  end

  def frameset
    @frameset ||= Frameset.find(params[:frameset_id])
  end
end
