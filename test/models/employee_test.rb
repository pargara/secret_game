require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'employee cant be created without a id' do
    employee = Employee.new(name: 'Sebastian')
    assert_not employee.save
  end

  test 'employee cant be created with unsafe params' do
    area = Area.create(name: 'Test')
    employee = Employee.new(name: 'sebastian--', id: 1)
    assert_not employee.save
  end
end
