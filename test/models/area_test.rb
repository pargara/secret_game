require "test_helper"

class AreaTest < ActiveSupport::TestCase
  test 'Area cant be created with unsafe params' do
    area = Area.new(name: 'pureba -')
    assert_not area.save
  end

  test 'Area cant be created with a name with less than 3 characters' do
    area = Area.new(name: 'a')
    assert_not area.save
  end

  test 'the name of the area cant be repeated' do
    area = Area.new(name: 'nombre_repetido')
    area.save
    area2 = Area.new(name: 'nombre_repetido')
    assert_not area2.save
  end

  test 'The name of the area cant be nil' do
    area = Area.new(name: '')
    assert_not area.save
  end
end
