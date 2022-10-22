module Colors
  COLORS = %w[yellow orange blue green white cyan]

  def print_colors
    puts "Here are the possible colors, #{COLORS}"
  end

  def gen_color_combination(num)
    combi = []
    num.times {combi << COLORS.sample}
    combi
  end

end

class HumanPlayer

  attr_accessor :name

  include Colors

  def initialize(name)
    @name = name
    @combination = []
  end

  def get_player(solution_or_guess)
    puts "Hello #{@name}, please input your #{solution_or_guess}!"
    @combination = gets.chomp.split
  end

  def print_combination
    puts "The combination is #{@combination}"
  end

end

class CopmuterPlayer

  attr_reader :combination

  include Colors

  def initialize
    @combination = []
  end

  def gen_combination
    @combination = gen_color_combination(4)
  end

  def print_combination
    puts "The combination is #{@combination}"
  end

end

class Feedback

  attr_reader :feedback

  def initialize(guess, solution)
    @guess = guess.map {|v| v = v}
    @solution = solution.map {|v| v = v}
    @feedback = []
  end

  def find_exact
    @guess.each_with_index do |color, index|
      if @solution[index] == color
        @feedback << 2
        @solution[index] = "check"
        @guess[index] = "done"
      end
    end
  end

  def find_almost
    @guess.each do |color|
      if @solution.include?(color)
        @feedback << 1
        @solution[@solution.index(color)] = "check"
        color = "done"
      end
    end
  end

  def gen_result
    find_exact
    find_almost
    until @feedback.length == 4 do @feedback << 0 end
  end

  def print_feedback
    puts "The feedback is #{@feedback}"
  end
end

class MastermindGuesser

  attr_reader :guess, :solution

  TURNS = 12

  def initialize
    @guesser = HumanPlayer.new("player1")
    @creator = CopmuterPlayer.new
    @solution = @creator.gen_combination
    @guess = []
    @feedback = []
    @turns_left = TURNS
  end

  def set_player_name
    puts "Hello player1 how should I call you ?"
    @guesser.name = gets.chomp
  end

  def gen_feedback
    feedback = Feedback.new(@guess, @solution)
    feedback.gen_result
    @feedback = feedback.feedback
  end

  def get_guess_and_gen_feedback
    @guess = @guesser.get_player("guess")
    gen_feedback
  end

  def print_info
    puts "This is the solution #{@solution}"
    puts "This is the guess #{@guess}"
    puts "This is the feedback #{@feedback}"
    puts "You have #{@turns_left} guesses left"
  end

  def victory
  @feedback.join == "2222"
  end

  def turns_loop
    until @turns_left == 0 || victory
      get_guess_and_gen_feedback
      @turns_left -= 1
      print_info
    end
  end

  def play
    set_player_name
    turns_loop
  end

end

class MastermindCreator
end

possible_codes = []

for num in (1111..6666)
  a = num.to_s.split("")
  unless a.include?('7') || a.include?('8') || a.include?('9') || a.include?('0')
    possible_codes << a
  end
end

possible_codes.each do |code|
  p code
end

p possible_codes.length

my_game = MastermindGuesser.new
my_game.play
puts "This is the solution #{my_game.solution}"
puts "This is the guess #{my_game.guess}"
p my_game.guess




