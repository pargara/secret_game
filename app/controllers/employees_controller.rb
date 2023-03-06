class EmployeesController < ApplicationController
  def index
    @employees = Employee.includes(:area).all
    render json: @employees, only: %i[id name], include: [area: { only: [:name] }]
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save!
      render json: @employee, only: %i[id name], include: [area: { only: [:name] }], status: :created
    else
      render json: @employee, status: :unprocessable_entity
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :year_game, :area_id)
  end
end
