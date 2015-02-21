class CompsController < ApplicationController

  def index
  end

  def new
  end

  def create
    redirect_to :index
  end

  def destroy
    redirect_to :index
  end
end
