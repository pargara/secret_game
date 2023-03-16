class PairGenerator
  attr_accessor :leftover, :pairs

  def initialize
    @pairs = []
    @names = []
    employees_names
    generate_pairs
  end

  def employees_names
    @employees = Employee.all

    @employees.each do |position|
      @names << position[:name]
    end
  end

  def generate_pairs
    shuffle_employees = @names.shuffle

    shuffle_employees.each_slice(2) do |a, b|
      if b.nil?
        @leftover = (a || b)
      else
        @pairs << [a, b]
      end
    end
  end

  def check_previous_game
    previous_games = Game.where(year: (self.year - 2)..(self.year - 1)).order(year: :asc)

    previous_game_pairs = previous_games.flat_map(&:pairs)
    @has_repeated_pairs = !previous_game_pairs & @pairs.empty?

    generate_pairs until @has_repeated_pairs
  end

  def change_leftover
    last_game = Game.where(year: (self.year - 1))

    previous_game_leftover = last_game.flat_map(&:leftover)

    if self.leftover == previous_game_leftover
      rand_position = rand(@pairs.length)
      new_leftover = @pairs[rand_position]
      @pairs[rand_position] = self.leftover
      self.leftover = new_leftover
    end
  end

  def self.generate_pairs
    generate_pairs
  end
end
