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
  ## After refactoring
  def self.check_previous_game(game)
    @game = game
    previous_games = Game.where(year: (@game.year - 2)..(@game.year - 1)).order(year: :asc)
    if previous_games.length > 1
      previous_game_pairs = previous_games.flat_map(&:couples)

      previous_game_pairs_parsed = previous_game_pairs.map { |str| eval(str) }
      games_couples_parsed = eval(@game.couples)

      generator = PairGenerator.new
      generator.create_couples_until_not_repeated(previous_game_pairs_parsed, games_couples_parsed, @game)
      generator.change_leftover(@game)
    end
  end

  def create_couples_until_not_repeated(previous_game_pairs_parsed, games_couples_parsed, game)
    @game = game
    @has_repeated_pairs = contains_pairs(previous_game_pairs_parsed, games_couples_parsed)
    # Jairo si ves la linea de abajo, sinceramente lo siento y se que no hay excusa para usar eso
    while @has_repeated_pairs
      generate_pairs
      games_couples_parsed = eval(@game.couples)
      @has_repeated_pairs = contains_pairs(previous_game_pairs_parsed, games_couples_parsed)
    end
  end

  def contains_pairs(previous_game_parsed, games_couples_parsed)
    pairs = previous_game_parsed.flatten(1)

    games_couples_parsed.each do |pair|
      return true if pairs.include?(pair)
    end
    false
  end

  def change_leftover(game)
    @game = game
    last_game = Game.where(year: (@game.year - 1))
    previous_game_leftover = last_game.flat_map(&:left)

    if !previous_game_leftover.empty? && previous_game_leftover.include?(@game.left)
      rand_position = rand(@pairs.length)
      new_leftover = @pairs[rand_position][rand_position]
      @pairs[rand_position] = @game.left
      @game.left = new_leftover
    end
  end
end
