module AreaAssertions
  def areaasserts
    area = Area.find(response_body['id'])
    binding.break
    assert_equal create_area_valid_keys, response_body.keys, 'Create area_response'
    assert_equal area.id, response_body['id'], 'area id'
    assert_equal area.name, response_body['name'], 'area name'
  end
end
