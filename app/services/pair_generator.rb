class PairGenerator
  attr_accessor :leftover, :pairs

  def initialize
    @pairs = []
    @names = []
    employees_names
    generate_pairs
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

  def employees_names
    @employees = Employee.all
    @employees.each do |position|
      @names << position[:name]
    end
  end
end
