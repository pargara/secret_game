require "test_helper"

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'game cant be created with excluded range of year' do
    game = Game.new(year: 2023)
    assert_not game.save
  end
end
