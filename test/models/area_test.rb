require "test_helper"

class AreaTest < ActiveSupport::TestCase
  test 'Area cant be created with unsafe params' do
    area = Area.new(name: 'pureba -')
    assert_not area.save
  end
end
