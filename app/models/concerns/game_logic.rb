module GameLogic
  attr_accessor :pairs, :names

  extend ActiveSupport::Concern

  def setting_employees
    @employees = Employee.all
    all_employees(@employees)
  end

  def all_employees(employees)
    @names = []
    @employees.each do |position|
      @names << position[:name]
    end
    generate_pairs(@names)
  end

  def generate_pairs(names)
    @pairs = []
    @leftover = []
    shuffle_employees = @names.shuffle

    shuffle_employees.each_slice(2) do |a, b|
      if b.nil?
        @leftover << (a || b)
      else
        @pairs << [a, b]
      end
    end
    self.couples = @pairs
    self.left = @leftover
  end

  def check_previous_game
    previous_games = Game.where(year: (year - 2)..(year - 1)).order(year: :asc)
    if previous_games.length > 1
      previous_game_pairs = previous_games.flat_map(&:couples)

      create_couples_until_not_repeated(previous_game_pairs, couples)
      last_year
    end
  end

  def create_couples_until_not_repeated(previous_game_pairs, couples)
    binding.break
    @has_repeated_pairs = contains_pairs(previous_game_pairs, couples)
    while @has_repeated_pairs
      setting_employees
      @has_repeated_pairs = contains_pairs(previous_game_pairs, couples)
    end
  end

  def contains_pairs(previous_game, couples)
    couples.each do |pair|
      return true if previous_game.to_set.superset?(pair.to_set)
    end
    false
  end

  def last_year
    last_game = Game.where(year: (year - 1))
    previous_game_leftover = last_game.flat_map(&:left)

    if !previous_game_leftover.empty? && previous_game_leftover.include?(self.left)
      change_leftover
    end
  end

  def change_leftover
    rand_position = rand(self.pairs.length)
    new_leftover = self.pairs[rand_position][rand_position]
    self.pairs[rand_position] = self.left
    self.left = new_leftover
  end
end
