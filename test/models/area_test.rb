require "test_helper"

class AreaTest < ActiveSupport::TestCase
  def setup
    @area_one = areas(:area_one)
    @employee = employees(:employee_one)
  end

  test 'colum name is valid' do
    assert Area.column_names.include?('name'), 'name column is included in Area table'
    assert_equal 'string', area_column_class('name').type.to_s, 'name column is a string'
    assert_not area_column_class('name').null, 'name column is not null'
  end

  test 'area have a relationship with a employee' do
    assert_equal @area_one, @employee.area, 'An area should have employees'
  end

  test 'Area cant be created with unsafe params' do
    area = Area.new(name: 'pureba -')
    assert_not area.save, 'An area cant be created with unsafe params'
  end

  test 'Area cant be created with a name with less than 3 characters' do
    area = Area.new(name: 'a')
    assert_not area.save, 'The length of the name must be greater than 3 characters'
  end

  test 'the name of the area cant be repeated' do
    area = Area.create(name: 'nombre_repetido')
    area2 = Area.new(name: 'nombre_repetido')
    assert_not area2.save, 'We cant created repeated areas'
  end

  test 'The name of the area cant be nil' do
    area = Area.new
    assert_not area.save
  end

  def area_column_class(column)
    Area.columns.detect { |each| each.name == column.to_s }
  end
end
