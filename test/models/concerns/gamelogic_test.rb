require 'test_helper'

class GameLogicTest < ActiveSupport::TestCase
  include GameLogic

  fixtures :employees
  attr_accessor :pairs, :names, :couples, :left, :year

  def setup
    @game = Game.new
    @game.setting_employees
  end

  test 'The couples are created correctly' do
    assert @game.couples[0].count >= 2
  end

  test 'the couples arent repeated' do
    previous_games = [games(:game_one), games(:game_two), games(:game_three)]
    previous_game_pairs = previous_games.map(&:couples)
    @game.year = 2026
    binding.break

    @game.create_couples_until_not_repeated(previous_game_pairs, @game.couples)

    assert_not contains_pairs?(previous_game_pairs, @game.couples), 'employees are not repeated'
  end

  test 'the leftover is assign correctly' do
    setting_employees
    assert !@leftover.nil?
  end

  test 'the leftover is not repeated' do
    @last_leftover = []
    2.times do
      setting_employees
      @game.change_leftover
      @last_leftover << left
    end
    assert left != @last_leftover[0], 'left is not repeated'
  end

  def contains_pairs?(previous_game_pairs, couples)
    couples[0].each do |pair|
      previous_game_pairs_sorted = previous_game_pairs.map {|pair| pair.sort }
      return true if @game.couples.any? { |pair| previous_game_pairs_sorted.include?(pair.sort) }
    end
    false
  end
end
