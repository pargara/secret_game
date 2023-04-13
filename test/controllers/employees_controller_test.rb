require "test_helper"
require_relative '../support/controller/employees_params'
require_relative '../support/controller/employees_assertions'
require_relative '../support/controller/parse_response'

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  include ParseResponse
  include EmployeesParams
  include EmployeesAssertions

  def setup
    @area_one = areas(:area_one)
  end

  test 'get index is successful' do
    get employees_path
    assert_response :success
    assert_equal Employee.all.size, length_body, 'Index all areas'
  end

  test 'post create create a employee ' do
    post_employees(employees_params)
    assert_response :success, 'Create a new employee'
    employeesasserts
  end

  # test 'post create dont create a employee' do
  #   post_employees(invalid_employees_params)
  #   post employees_path, params: { employee: { name: 'Sebastian', area_id: 1 } }
  #   assert_response :unprocessable_entity, 'The create acction let us create a new employee'
  # end

  def post_employees(params)
    post employees_path params: params
  end
end
