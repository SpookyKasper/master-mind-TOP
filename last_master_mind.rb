# frozen_string_literal: true

module Colors
  COLORS = %w[yellow orange blue green white cyan].freeze

  def print_colors
    puts "Here are the possible colors, #{COLORS}"
  end

  def gen_color_combination(num)
    combi = []
    num.times { combi << COLORS.sample }
    combi
  end

  def create_set_of_possible_codes
    possible_codes = []
    (1111..6666).each do |num|
      a = num.to_s.split('')
      unless a.include?('7') || a.include?('8') || a.include?('9') || a.include?('0')
        possible_codes << a.map { |num| COLORS[num.to_i - 1] }
      end
    end
    possible_codes
  end
end

class Feedback
  attr_reader :feedback, :possibilities

  def initialize(guess, solution)
    @guess = guess.map { |v| v }
    @solution = solution.map { |v| v }
    @feedback = []
    @possibles = []
  end

  def find_exact
    @guess.each_with_index do |color, index|
      next unless @solution[index] == color

      @feedback << 2
      @solution[index] = 'check'
      @guess[index] = 'done'
    end
  end

  def find_almost
    @guess.each_with_index do |color, index|
      next unless @solution.include?(color)

      @feedback << 1
      @solution[@solution.index(color)] = 'check'
      @guess[index] = 'done'
    end
  end

  def gen_result
    find_exact
    find_almost
    @feedback << 0 until @feedback.length == 4
  end
end

class Mastermind
  attr_reader :guess, :solution

  include Colors

  TURNS = 8

  def initialize(name)
    @name = name
    @solution = nil
    @guess = []
    @feedback = []
    @possible_codes = create_set_of_possible_codes
    @set = create_set_of_possible_codes
    @turn = 0
  end

  def get_combination(solution_or_guess)
    puts "So #{@name}, please input your #{solution_or_guess}!"
    gets.chomp.split
  end

  def gen_feedback(guess, solution)
    feedback = Feedback.new(guess, solution)
    feedback.gen_result
    feedback.feedback
  end

  def find_guess_score
    @possible_codes.each
  end

  def gen_guess
    return gen_color_combination(4) if @guess.empty?

    @set = @set.select { |code| gen_feedback(@guess, code) == @feedback }
    @set.sample
  end

  def print_info
    puts "This is the solution #{@solution}"
    puts "This was the guess #{@guess}"
    puts "This is the feedback #{@feedback}"
    puts "You have #{TURNS - @turn} guesses left"
  end

  def victory?
    @feedback.join == '2222'
  end

  def print_victory_text
    puts "Congratulations you cracked the code in #{@turn} turns!"
  end

  def print_end_text
    puts 'You run out of guesses this time! Wanna try another game ?'
  end

  def play_guesser
    @solution = gen_color_combination(4)
    until @turn == TURNS || victory?
      @guess = get_combination('guess')
      @feedback = gen_feedback(@guess, @solution)
      @turn += 1
      print_info
    end
    victory? ? print_victory_text : print_end_text
  end

  def play_creator
    @solution = get_combination('code')
    until @turn == TURNS || victory?
      p @set.length
      @guess = gen_guess
      @feedback = gen_feedback(@guess, @solution)
      p @possible_codes.length
      p @set.length
      @turn += 1
      print_info
    end
    victory? ? print_victory_text : print_end_text
  end
end

# puts "I hear you are here to play Mastermind !?"
# puts "So let's go! before we start do you want to be the creator or the guesser ?"
# choice = gets.chomp
# puts "Cool!, now tell me your name please"
# my_game = Mastermind.new(gets.chomp)
# choice == 'creator' ? my_game.play_creator : my_game.play_guesser
my_mastermind = Mastermind.new('Daniel')
my_mastermind.play_creator
