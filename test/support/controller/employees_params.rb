module EmployeesParams
  def employees_params
    { employee: { name: 'Sebastian', area_id: @area_one.id } }
  end

  def invalid_employees_params
    { employee: { name: 'se' } }
  end

  def create_employee_valid_keys
    %w[id name year_game area]
  end
end
