class ExportsController < ApplicationController

  def index
  end

  def create
    @export = Export.create
  end
end
