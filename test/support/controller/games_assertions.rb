module GameAssertions
  def gameasserts
    binding.break
    game = Game.find(response_body['id'])
    assert_equal create_game_valid_keys, response_body.keys, 'Create game_response'
    assert_equal game.id, response_body['id'], 'game id'
    assert_equal game.year, response_body['year'], 'game year'
  end
end
