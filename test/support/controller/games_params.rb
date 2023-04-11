module GamesParams
  def game_params
    { game: { year: 2027 } }
  end

  def invalid_game_params
    { game: { year: 2090 } }
  end

  def create_game_valid_keys
    %w[id year]
  end
end
