class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def create
    @game = Game.new(game_params)
  end

  private

  def game_params
    params.require(:game).permit(:year, :couples, :left)
  end
end
