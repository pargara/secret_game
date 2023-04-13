require "test_helper"
require_relative '../support/controller/parse_response'
require_relative '../support/controller/areas_params'
require_relative '../support/controller/areas_assertions'

class AreasControllerTest < ActionDispatch::IntegrationTest
  include ParseResponse
  include AreasParams
  include AreaAssertions

  test 'get index is successful' do
    get areas_path
    assert_response :success
    assert_equal Area.all.size, length_body, 'Index all areas'
  end

  test 'post create create an area' do
    post_game(area_params)
    assert_response :success, 'post create a new area'
    areaasserts
  end

  # test 'post create dont create an area' do
  #   post_game(invalid_area_params)
  #   # post areas_path, params: { area: { name: '####' } }
  #   assert_response :unprocessable_entity, 'post dont create an area'
  # end

  def post_game(params)
    post areas_path params: params
  end
end
