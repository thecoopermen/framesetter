class FramesetsController < ApplicationController

  def index
    @framesets = Frameset.order(created_at: :desc)
  end
end
