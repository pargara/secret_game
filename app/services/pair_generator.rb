class PairGenerator
  attr_accessor :leftover, :pairs

  def initialize
    @employees = Employee.all
    @pairs = []
    @leftover = nil
  end

  def generate_pairs
    shuffle_employees = @employees.shuffle
    shuffle_employees.each_slice(2) do |a, b|
      if b.nil?
        @leftover = a
      else
        @pairs << [a, b]
      end
    end
    return @leftover
    return @pairs
  end

  def leftover_employee
    @leftover
  end

  def check_previous_game
    @previous_games = Game.where(year: (self.year - 2)..(self.year - 1)).order(year: :asc)
    return if @previous_games.blank?

    last_game = @previous_games.last

    self.couples = last_game.couples.shuffle if last_game

    if self.couples == previous_games.first.couples || self.couples == last_game.couples
      generate_couples
    end

    self.left = self.couples.pop.last if self.couples.any? && self.couples.last.size == 1
  end
end
