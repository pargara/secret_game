class AreasController < ApplicationController
  def index
    @areas = Area.all
  end

  def new
    @area = Area.new(area_params)
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end
end
