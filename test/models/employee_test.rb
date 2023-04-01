require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  test 'employee cant be created without an area_id' do
    employee = Employee.new(name: 'Sebastian')
    assert_not employee.save
  end

  test 'employee cant be created with unsafe params' do
    area = Area.create(name: 'Test')
    employee = Employee.new(name: 'sebastian--', id: 1)
    assert_not employee.save
  end

  test 'the name of the employee should have at least 3 characters' do
    area = Area.create(name: 'Test')
    employee = Employee.new(name: 'se', id: 1)
    assert_not employee.save
  end

  test 'the name of the employee cant be nil' do
    area = Area.create(name: 'Test')
    employee = Employee.new(name: '', id: 1)
    assert_not employee.save
  end
end
