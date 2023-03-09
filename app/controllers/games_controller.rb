class GamesController < ApplicationController
  def index
    @games = Game.all
    render json: @games, only: %i[id couples left]
  end

  def create
    @game = Game.new(game_params)
    @generator = PairGenerator.new
    @game.couples = @generator.generate_pairs
    @game.left = @generator.leftover_employee

    if @game.save!
      render json: @game, only: [:year], status: :created
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:year, :left, couples: [])
  end
end
