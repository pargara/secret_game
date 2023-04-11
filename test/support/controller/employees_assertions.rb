module EmployeesAssertions
  def employeesasserts
    employee = Employee.find(response_body['id'])
    assert_equal create_employee_valid_keys, response_body.keys, 'Create employee response'
    assert_equal employee.id, response_body['id'], 'employee id'
    assert_equal employee.name, response_body['name'], 'employee name'
  end
end
