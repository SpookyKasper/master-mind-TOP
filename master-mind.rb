# display some explanation for the player
puts
puts "Hello player!"
puts "Let's play mastermind!"
puts
puts "Instructions:"
puts "Please make your guess using a combination of 4 colors seperated with spaces"
puts "Example: orange yellow blue white"
puts
puts "Feedback will be given by an array of numbers"
puts "A 2 means some color of the guess is present in the secret code and in the same place"
puts "A 1 means some color is present but not in the same place"
puts "A 0 means the color is not present in the secret code "
puts "Example: imagine the code is 'yellow orange blue white'"
puts "And your guess was           'orange purple blue yellow'"
puts "You'll get a feedback of [2, 1, 1, 0]"
puts "Feedback explanation:"
puts "The '2' means one color (here the 'blue') is present and in the same place"
puts "The two '1' mean two colors (here the yellow and orange) are present but not in the same place"
puts "And finally the '0' means one of the colors (here the purple) is not present in the code"
puts
puts "Got it?"
puts "Coool! Let's crack some codes!"
puts "You have 12 tries, good luck!"

class Mastermind
  def initialize(chances)
    @code_cracked = false
    @chances = chances
    @guesses_left = @chances
    @colors = %w(yellow orange purple blue white cyan)
    @computer_code = @colors.sample(4)
    @user_code = nil
    @guesses_array = []
    @feedbacks_array = []
  end

  def gen_user_code
    puts "Pick four colors for your secret code"
    puts "Remember the colors are #{@colors}"
    gets.chomp.downcase.split
  end

  def get_user_input
    valid = false
    until valid
      puts
      puts "You have #{@guesses_left} guesses left"
      puts "Remember, the possible colors are: #{@colors}"
      puts
      puts "So darling what is your #{@chances - @guesses_left + 1} guess ?"
      guess = gets.chomp.downcase.split
      if guess.all? { |color| @colors.include?(color) } && guess.length == 4
        @guesses_array << guess
        valid = true
      else
        puts 'Mmh something is wrong with your input, please type 4 colors seperated with spaces'
        puts 'Like so: yellow orange blue green'
      end
    end
    guess
  end

  def compare_guess_with_code(guess, code)
    feedback = []
    guess.each_with_index do |color, index|
      if code.index(color) == index then feedback << 2
      elsif code.include?(color) && code.index(color) != index then feedback << 1
      else feedback << 0
      end
    end
    @feedbacks_array << feedback.sort.reverse
    feedback
  end

  def gameover?
    @guesses_left == 0 || @code_cracked
  end

  def display_sofar
    index = 0
    puts
    while index < @guesses_array.length
      puts "Your pair guess & feedback for guess #{index + 1} was " +
           @guesses_array[index].to_s + " " + @feedbacks_array[index].to_s
      index += 1
    end
  end

  def play_against_computer
    until gameover?
      guess = get_user_input
      feedback = compare_guess_with_code(guess, @computer_code)
      @guesses_left -= 1
      display_sofar
      if feedback.all?(2)
        puts "Congratulations!! you cracked the code!!!"
        @code_cracked = true
      end
    end
  end
end

mastermind = Mastermind.new(12)
mastermind.play_against_computer
