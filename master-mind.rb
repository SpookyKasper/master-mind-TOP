# display some explanation for the player
puts "Hello player!"
puts "Please make your guess using a combination of 4 colors seperated with spaces"
puts "Example: Green yellow blue white"
puts "Or: cyan white blue orange"
puts "Feedback will be given by an array of numbers"
puts "A 2 means some color of the guess is present in the code and in the same place as in the code"
puts "A 1 means some color is present in the code but not in the same place as in the code"
puts "A 0 means the color is not present in the code"
puts "Example: imagine the code is 'yellow orange blue white'"
puts "And you made a guess of 'orange green blue yellow'"
puts "You'll get a feedback similar to [2, 1, 1, 0]"
puts "Indeed one color (the blue) is present and in the same place"
puts "Two colors (the yellow and orange) are present but not in the same place"
puts "And finally one of the colors (the green) is not present in the code"
puts "Got it?"
puts "Coool! Let's go!"
puts "You have 12 tries, good luck!"

class Mastermind
  def initialize
    @player_found_code = false
    @guesses_left = 12
    @colors = %w(yellow orange purple blue white cyan)
  end

  def get_user_input
    puts "You have #{@guesses_left} guesses left"
    puts "Remember, the possible colors are: #{@colors}"
    puts "So darling what is your guess ?"
    gets.chomp.downcase.split
  end

  def gen_computer_code
    @colors.sample(4)
  end

  def gen_user_code
    puts "Pick four colors for your secret code"
    puts "Remember the colors are #{@colors}"
    gets.chomp.downcase.split
  end

  def compare_guess_with_code(guess, code)
    feedback_array = []
    guess.each_with_index do |color, index|
      if code.index(color) == index then feedback_array << 2
      elsif code.include?(color) && code.index(color) != index then feedback_array << 1
      else feedback_array << 0
      end
    end
    feedback_array
  end

  def code_cracked?(feedback)
    feedback.count(2) == 4
  end

  def player_won
    puts "Congratulations"
  end

  def gameover?
    @guesses_left == 0 || @player_found_code
  end

  def play
    code = gen_computer_code
    until gameover?
      guess = get_user_input
      feedback = compare_guess_with_code(guess, code)
      p code
      p "Your guess was '#{guess.join(" ")}'"
      p "And the feedback for your guess is #{feedback.sort.reverse}"
      @guesses_left -= 1
      if code_cracked?(feedback)
        @player_found_code = true end
    end
  end
end

mastermind = Mastermind.new
mastermind.play
