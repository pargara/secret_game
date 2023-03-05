class AreasController < ApplicationController
  def index
    @areas = Area.all
    render json: @areas, only: [:id, :name]
  end

  def create
    @area = Area.new(area_params)

    if @area.save
      render json: @area, only: [:id, :name], status: :created
    else
      render json: @area.errors, status: :unprocessable_entity
    end
  end

  private

  def area_params
    params.require(:area).permit(:name)
  end
end
