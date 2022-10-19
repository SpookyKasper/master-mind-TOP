# Algo:
# Make the computer generate a code
# Ask the user for a guess
# Give Feedback on that guess

module Colors
  COLORS = %w[yellow orange blue green white cyan]

  def print_colors
    puts "Here are the possible colors, #{COLORS}"
  end
end

class Creator

  include Colors

  def initialize(name)
    @name = name
    @solution = []
  end

  def gen_solution
    4.times {@solution << COLORS.sample}
  end

  def print_solution
    puts "The solution is #{@solution}"
  end
end

class Guesser

  include Colors

  def initialize(name)
    @name = name
    @guess = []
  end

  def get_guess
    puts "Hello #{@name}, please input your guess!"
    @guess = gets.chomp.split
  end

  def print_guess
    puts "Your guess was #{@guess}"
  end
end

class Combination
  def initialize(color1, color2, color3, color4)
    @color1 = color1
    @color2 = color2
    @color3 = color3
    @color4 = color4
  end
end

class Feedback
  def initialize(guess, solution)
    @guess = guess
    @solution = solution
    @result = []
  end

  def give_result
    @guess.each_with_index do |color, index|
      if @solution[index] == color then @result << 2 and @solution[index] = "check"
    end
    @guess.each {|color| if @solution.include?(color) then @result << 1 end}
    until @result.length == 4 do @result << 0 end
  end
end


possible_codes = []

for num in (1111..6666)
  a = num.to_s.split("")
  unless a.include?('7') || a.include?('8') || a.include?('9') || a.include?('0')
    possible_codes << a
  end
end

def feedback_giver(guess, solution)

end

possible_codes.each do |code|
  p code
end

p possible_codes.length


puts "Hello Master Mind Player!! How should I call you ?"
name = gets.chomp
daniel = Guesser.new(name)
computer = Creator.new("Computer")

daniel.get_guess
daniel.print_guess
daniel.print_colors
computer.gen_solution
computer.print_solution


end
