class GamesController < ApplicationController
  def index
    @games = Game.all
    render json: @games, only: %i[id couples left]
  end

  def create
    @game = Game.new(game_params)

    create_couples

    if @game.save
      render json: @game, only: [:year], status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:year, :left, :couples)
  end

  def create_couples
    @generator = PairGenerator.new
    @game.couples = @generator.pairs
    @game.left = @generator.leftover
    check_previous_game
  end

  def check_previous_game
    previous_games = Game.where(year: (@game.year - 2)..(@game.year - 1)).order(year: :asc)
    if previous_games.length >= 2
      previous_game_pairs = previous_games.flat_map(&:couples)

      previous_game_pairs_parsed = previous_game_pairs.map { |str| eval(str) }
      games_couples_parsed = eval(@game.couples)

      @has_repeated_pairs = contains_pairs(previous_game_pairs_parsed, games_couples_parsed)
    end

    create_couples if @has_repeated_pairs
  end

  def contains_pairs(array1, array2)
    pairs = array1.flatten(1)
    array2.each do |pair|
      return true if pairs.include?(pair)
    end
    false
  end
end
