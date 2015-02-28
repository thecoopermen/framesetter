class FramesetsController < ApplicationController

  def index
    @framesets = Frameset.order(created_at: :desc).includes(:frames)
  end
end
