class GamesController < ApplicationController
  def index
    @games = Game.all
    render json: @games, only: %i[id couples left]
  end

  def create
    @game = Game.new(game_params)

    setting_names

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

  def setting_names
    @generator = PairGenerator.new
    @game.couples = @generator.pairs
    @game.left = @generator.leftover
  end
end
