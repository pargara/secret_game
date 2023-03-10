class PairGenerator
  attr_accessor :leftover, :pairs

  def initialize
    @employees = Employee.all
    @pairs = []
    @leftover = nil
    generate_pairs
  end

  def generate_pairs
    shuffle_employees = @employees.shuffle
    shuffle_employees.each_slice(2) do |a, b|
      if b.nil?
        @leftover = b
      else
        @pairs << [a, b]
      end
    end
  end
end
