# frozen_string_literal: true

class Mastermind
  COLORS = %w[yellow orange purple blue white cyan].freeze
  TURNS = 3

  def initialize
    @code_cracked = false
    @guesses_left = TURNS
    @code = nil
    @current_guess = nil
    @current_feedback = nil
    @guesses_array = []
    @feedbacks_array = []
    @previous_pairs = {}
  end

  def print_instruction
    puts 'Instructions:'
    puts 'Please make your guess using a combination of 4 colors seperated with spaces'
    puts 'Example: orange yellow blue white'
    puts
    puts 'Feedback will be given by an array of numbers'
    puts 'A 2 means some color of the guess is present in the secret code and in the same place'
    puts 'A 1 means some color is present but not in the same place'
    puts 'A 0 means the color is not present in the secret code '
    puts "Example: imagine the code is 'yellow orange blue white'"
    puts "And your guess was           'orange purple blue yellow'"
    puts "You'll get a feedback of [2, 1, 1, 0]"
    puts 'Feedback explanation:'
    puts "The '2' means one color (here the 'blue') is present and in the same place"
    puts "The two '1' mean two colors (here the yellow and orange) are present but not in the same place"
    puts "And finally the '0' means one of the colors (here the purple) is not present in the code"
    puts
    puts 'Got it?'
    puts "Coool! Let's crack some codes!"
    puts 'You have 12 tries, good luck!'
  end

  def print_guess_request
    puts
    puts "You have #{@guesses_left} guesses left"
    puts "Remember, the possible colors are: #{COLORS}"
    puts
    puts "So darling what is your #{TURNS - @guesses_left + 1} guess ?"
  end

  def print_code_request
    puts
    puts 'Please pick four colors for your secret code'
    puts "Remember the possible colors are #{COLORS}"
  end

  def print_wrong_input
    puts
    puts 'Mmh something is wrong with your input, please type 4 colors seperated with spaces'
    puts 'Like so: yellow orange blue blue'
  end

  def set_user_code
    time_to_stop = false
    until time_to_stop
      print_code_request
      code = gets.chomp.downcase.split
      next print_wrong_input unless valid_input?(code)

      @code = code
      time_to_stop = true
    end
  end

  def gen_color_combination
    combination = []
    4.times { combination << COLORS.sample }
    combination
  end

  def valid_input?(input)
    input.all? { |color| COLORS.include?(color) } && input.length == 4
  end

  def get_user_guess
    time_to_stop = false
    until time_to_stop
      print_guess_request
      guess = gets.chomp.downcase.split
      next print_wrong_input unless valid_input?(guess)

      @current_guess = guess
      @guesses_array << guess
      time_to_stop = true
    end
  end

  def does_guess_match_feedback?(_guess, feedback)
    # for every 2 in the feedback there must be a color at the same place in the guess
    # for every 1 in the feedback that color must be present in the guess
    # for every 0 in the feedback there must be a color not present in the guess
    exact = feedback.count(2)
    almost = feedback.count(1)
    nope = feedback.count(0)
    # compare guess and feedback and count how many are exact matches
  end

  def gen_possible_solution
    keepgoing = true
    while keepgoing
      # compare option to guess + feedback pair
      # if feedback says 2 option gets the same color
      # if feedback says 1 pick another color from the guess
      # if feedback says 0 pick a color not present in guess
      index = 0
      result = []
      @feedbacks_array.each do |feedback|
        feedback.each_with_index do |num, i|
          current_guess = @guesses_array[index]
          color = current_guess[i]
          case num
          when 2
            result << color
            color = 'check'
          when 1
            left = current_guess.reject { |v| v == 'check' }
            result << left.sample
          when 0
            options = COLORS - current_guess
            result << options.sample
          end
        end
        keepgoing = false
        index += 1
      end
    end
    p result
    result
  end

  def gen_computer_guess
    @current_guess = if @guesses_array.empty?
                       gen_color_combination
                     else
                       # second guess varies until it matches the feedback of the pair guess + feedback
                       # example previous guess is orange orange blue blue, feedback is [2,1,0,0]
                       # new guess must have one color in the same place, 1 color moving places and 2 new colors
                       # until it is true for all guesses keep changing colors.f
                       gen_possible_solution

                     end
    @guesses_array << @current_guess
  end

  def compare_guess_with_code(guess, code)
    tempo_guess = guess.map { |v| v = v }
    @current_feedback = code.map.with_index do |color, i|
      if tempo_guess[i] == color
        tempo_guess[i] == 'checked'
        2
      elsif tempo_guess.include?(color)
        index = tempo_guess.find_index { |v| v == color }
        tempo_guess[index] = 'checked'
        1
      else
        0
      end
    end
    @feedbacks_array << @current_feedback
  end

  def gameover?
    @guesses_left.zero? || @code_cracked
  end

  def display_sofar
    puts
    p @code
    @guesses_array.each_with_index do |_guess, index|
      puts "The pair guess & feedback for guess #{index + 1} is #{@guesses_array[index]} #{@feedbacks_array[index]}"
    end
  end

  def player_guesser
    print_instruction
    @code = gen_color_combination
    until gameover?
      get_user_guess
      compare_guess_with_code(@current_guess, @code)
      @guesses_left -= 1
      display_sofar
      next unless @current_feedback.join == '2222'

      puts 'Congratulations!! you cracked the code!!!'
      code_cracked = true
    end
  end

  def player_creator
    set_user_code
    until gameover?
      gen_computer_guess
      feedback = compare_guess_with_code(@current_guess, @code)
      @guesses_left -= 1
      display_sofar
      next unless @current_feedback.join == '2222'

      puts 'The computer cracked the code!!!'
      @code_cracked = true
    end
  end
end

puts
puts 'Hello player!'
puts "Let's play mastermind!"
puts
puts 'Do you want to be the creator of the secret code ? or the guesser ?'
puts "Please type 'creator' or 'guesser' to answer the above question:"

mastermind = Mastermind.new
stop = false

mastermind.player_creator

until stop
  answer = gets.chomp.downcase
  case answer
  when 'creator'
    stop = true
    mastermind.player_creator
  when 'guesser'
    stop = true
    mastermind.player_guesser
  else
    puts 'Please input creator or guesser'
  end
end
