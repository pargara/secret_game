require "test_helper"

class GameTest < ActiveSupport::TestCase
  test 'the game of the year cant be nil' do
    game = Game.new(year: '')
    assert_not game.save
  end

  test 'game cant be created with excluded range of year' do
    game = Game.new(year: 2010)
    assert_not game.save
  end

  test 'the game should have at least 2 employees' do
    
  end
end
