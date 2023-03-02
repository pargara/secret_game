class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def create
    @employee = Employee.new(employee_params)
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :year_game)
  end
end
