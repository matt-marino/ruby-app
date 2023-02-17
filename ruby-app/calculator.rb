class Calculator
  def initialize(a, b)
    @a = a
    @b = b
  end

  def add
    @a + @b
  end

  def subtract
    @a - @b
  end

calc = Calculator.new(20, 11)
puts calc.add
puts calc.subtract
end
