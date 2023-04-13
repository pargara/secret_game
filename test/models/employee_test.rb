require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  def setup
    @employee = employees(:employee_one)
    @area = areas(:area_one)
  end

  test 'colum name is valid' do
    assert Employee.column_names.include?('name'), 'name column is included in Employee table'
    assert_equal 'string', employee_column_class('name').type.to_s, 'name column is a string'
    assert_not employee_column_class('name').null, 'name column is not null'

    assert Employee.column_names.include?('year_game'), 'name column is included in Employee table'
    assert_equal 'integer', employee_column_class('year_game').type.to_s, 'name column is a string'
    assert_not employee_column_class('year_game').null, 'name column is not null'
  end

  test 'Employee belongs to a Area' do
    assert_equal @area, @employee.area, 'the employee should belong to an area'
  end

  test 'employee cant be created without an area_id' do
    employee = Employee.new(name: 'Sebastian')
    assert_not employee.save, 'An employee cant be created whithout a reference to an area'
  end

  test 'employee cant be created with unsafe params' do
    employee = Employee.new(name: 'sebastian--', area_id: @area.id)
    assert_not employee.save, 'Employee cant be created with strange characters'
  end

  test 'the name of the employee should have at least 3 characters' do
    employee = Employee.new(name: 'se', area_id: @area.id)
    assert_not employee.save, 'the length of the employee name must be greater than 3 characters'
  end

  test 'the name of the employee cant be nil' do
    employee = Employee.new(name: '', area_id: @area.id)
    assert_not employee.save, 'An employee should have a name'
  end

  test 'create an employee set the year' do
    employee = Employee.create(name: 'sebastian', area_id: @area.id)
    assert_equal Date.today.year, employee.year_game, 'An employee should have a year'
  end

  def employee_column_class(column)
    Employee.columns.detect { |each| each.name == column.to_s }
  end
end
