require "test_helper"
require_relative '../support/controller/parse_response'
require_relative '../support/controller/games_params'
require_relative '../support/controller/games_assertions'

class GamesControllerTest < ActionDispatch::IntegrationTest
  include ParseResponse
  include GamesParams
  include GameAssertions

  test 'get index is successful' do
    get games_path
    assert_response :success
    assert_equal Game.all.size, length_body, 'Index all games'
  end

  test 'post create is successful' do
    post_game(game_params)
    # post games_path, params: { game: { year: 2023 } }
    assert_response :success
    gameasserts
  end

  test 'post create is not successful' do
    post_game(invalid_game_params)
    # post games_path, params: { game: {  year: 2050 } }
    assert_response :unprocessable_entity, "the create shouldn't create a new game with out of range year"
  end

  def post_game(params)
    post games_path params: params
  end
end
