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
    if previous_games.length > 1
      previous_game_pairs = previous_games.flat_map(&:couples)

      previous_game_pairs_parsed = previous_game_pairs.map { |str| eval(str) }
      games_couples_parsed = eval(@game.couples)

      create_couples_until_not_repeated(previous_game_pairs_parsed, games_couples_parsed)
    end
    # change_leftover
  end

  #def create_couples_until_not_repeated(previous_game_pairs_parsed,games_couples_parsed)
  #  @has_repeated_pairs = contains_pairs(previous_game_pairs_parsed, games_couples_parsed)
  #
  #  if contains_pairs(previous_game_pairs_parsed, games_couples_parsed)
  #    create_couples
  #    create_couples_until_not_repeated(previous_game_pairs_parsed, games_couples_parsed)
  #  else
  #    return
  #  end
  #end

  def create_couples_until_not_repeated(previous_game_pairs_parsed, games_couples_parsed)
    @has_repeated_pairs = contains_pairs(previous_game_pairs_parsed, games_couples_parsed)
    # Jairo si ves la linea de abajo, sinceramente lo siento y se que no hay excusa para usar eso
    while @has_repeated_pairs
      create_couples
      games_couples_parsed = eval(@game.couples)
      @has_repeated_pairs = contains_pairs(previous_game_pairs_parsed, games_couples_parsed)
    end
  end

  def contains_pairs(previous_game_parsed, games_couples_parsed)
    pairs = previous_game_parsed.flatten(1)

    games_couples_parsed.each do |pair|
      return true if pairs.include?(pair)
    end
    false
  end

  def change_leftover
    last_game = Game.where(year: (@game.year - 1))
    previous_game_leftover = last_game.flat_map(&:left)

    if !previous_game_leftover.empty? && previous_game_leftover.include?(@game.left)
      rand_position = rand(@generator.pairs.length)
      new_leftover = @generator.pairs[rand_position][rand_position]
      @generator.pairs[rand_position] = @game.left
      @game.left = new_leftover
    end
  end
end
