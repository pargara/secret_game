require "test_helper"

class GameTest < ActiveSupport::TestCase
  test 'column name is valid' do
    assert Game.column_names.include?('year'), 'year column is included in Game table'
    assert Game.column_names.include?('couples'), 'year column is included in Game table'
    assert Game.column_names.include?('left'), 'year column is included in Game table'
    assert_equal 'integer', game_column_class('year').type.to_s, 'year column is a integer'
    assert_equal 'json', game_column_class('couples').type.to_s, 'couples column is a string'
    assert_equal 'json', game_column_class('left').type.to_s, 'left column is a string'
    assert_not game_column_class('year').null, ' year column cant be null'
  end

  test 'the game of the year cant be nil' do
    game = Game.new(year: '')
    assert_not game.save
  end

  test 'game cant be created with excluded range of year' do
    game = Game.new(year: 2010)
    assert_not game.save
  end

  test 'the game should have at least 2 employees' do
    more_than_two_employees = true if employees.size >= 2
    assert more_than_two_employees, 'There should be at least 2 employees to create a game'
  end

  def game_column_class(column)
    Game.columns.detect { |each| each.name == column.to_s }
  end
end
