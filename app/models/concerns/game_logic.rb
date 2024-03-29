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
    @pairs =  []
    shuffle_employees = @names.shuffle

    shuffle_employees.each_slice(2) do |a, b|
      if b.nil?
        @leftover = (a || b)
      else
        @pairs << [a, b]
      end
    end

    self.couples = @pairs
    self.left = @leftover
  end

  def check_previous_game
    previous_games = Game.where(year: (self.year - 2)..(self.year - 1)).order(year: :asc)
    previous_game_pairs = previous_games.flat_map(&:couples)

    if previous_games.length >= 1
      previous_game_pairs_parsed = previous_game_pairs.map { |str| eval(str) }
      games_couples_parsed = eval(self.couples)

      create_couples_until_not_repeated(previous_game_pairs_parsed, games_couples_parsed)
      contains_the_leftover?
    end
  end

  def create_couples_until_not_repeated(previous_game_pairs_parsed, games_couples_parsed)
    while contains_pairs?(previous_game_pairs_parsed, games_couples_parsed)
      setting_employees
    end
  end

  def contains_pairs?(previous_game_parsed, games_couples_parsed)
    pairs = previous_game_parsed.flatten(1)

    games_couples_parsed.each do |pair|
      pairs.include?(pair) ? true : false
    end
  end

  def contains_the_leftover?
    last_game_leftover = Game.where(year: (self.year - 1))
    previous_game_leftover = last_game_leftover.flat_map(&:left)

    if previous_game_leftover.include?(self.left)
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
