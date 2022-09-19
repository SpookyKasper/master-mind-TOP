
class Mastermind

  def initialize(chances)
    @code_cracked = false
    @chances = chances
    @guesses_left = chances
    @colors = %w[yellow orange purple blue white cyan]
    @computer_code = nil
    @user_code = nil
    @current_guess = nil
    @current_feedback = []
    @guesses_array = []
    @feedbacks_array = []
  end

  def print_intro
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

  def gen_user_code
    puts
    puts "Coool! then let's get to it!"
    puts 'Please pick four colors for your secret code'
    puts "Remember the colors are #{@colors}"
    @user_code = gets.chomp.downcase.split
  end

  def gen_computer_code
    code = []
    4.times {code << @colors.sample}
    @computer_code = code
    code
  end

  def get_user_guess
    valid = false
    until valid
      puts
      puts "You have #{@guesses_left} guesses left"
      puts "Remember, the possible colors are: #{@colors}"
      puts
      puts "So darling what is your #{@chances - @guesses_left + 1} guess ?"
      guess = gets.chomp.downcase.split
      if guess.all? { |color| @colors.include?(color) } && guess.length == 4
        @current_guess = guess
        @guesses_array << guess
        valid = true
      else
        puts
        puts 'Mmh something is wrong with your input, please type 4 colors seperated with spaces'
        puts 'Like so: yellow orange blue green'
      end
    end
  end

  def computer_guess
    # make the computer adapt to the feedback
    # after making a first random guess
    # for every 2 in the feedback put a color in the same place
    # for every 1 in the feedback
    if @guesses_array.empty?
      guess = @colors.sample(4)
      @guesses_array << guess
    else
      @guesses_array.reduce() do |memo, (element, index)|
        correct_gems = feedbacks_array[index].count(2)
        p correct_gems
      end
    end
    guess
  end

  def compare_guess_with_code(guess, code)
    tempo_guess = guess.map {|v| v = v}
    code.each_with_index do |color, i|
      if tempo_guess[i] == color
        @current_feedback[i] = 2
        tempo_guess[i] == "checked"
      elsif tempo_guess.include?(color)
        @current_feedback[i] = 1
        index = tempo_guess.find_index {|v| v == color}
        tempo_guess[index] = "checked"
      else
        @current_feedback[i] = 0
      end
      p tempo_guess
    end
    @feedbacks_array << @current_feedback
  end

  def gameover?
    @guesses_left == 0 || @code_cracked
  end

  def display_sofar
    puts
    p @computer_code
    @guesses_array.each_with_index do |guess, index|
      puts "The pair guess & feedback for guess #{index + 1} is " +
            @guesses_array[index].to_s + ' ' + @feedbacks_array[index].to_s
    end
  end

  def player_guesser
    print_intro
    gen_computer_code
    until gameover?
      get_user_guess
      compare_guess_with_code(@current_guess, @computer_code)
      @guesses_left -= 1
      display_sofar
      if @current_feedback.join == '2222'
        puts 'Congratulations!! you cracked the code!!!'
          @code_cracked = true
      end
    end
  end

  def player_creator
    gen_user_code
    until gameover?
      guess = computer_guess
      feedback = compare_guess_with_code(guess, @user_code)
      @guesses_left -= 1
      display_sofar
      if feedback.all?(2)
        puts 'The computer cracked the code!!!'
          @code_cracked = true
      end
    end
  end
end

puts
puts 'Hello player!'
puts "Let's play mastermind!"
puts
puts "Do you want to be the creator of the secret code ? or the guesser ?"
puts "Please type 'creator' or 'guesser' to answer the above question:"

mastermind = Mastermind.new(12)
stop = false
until stop
  answer = gets.chomp.downcase
  case answer
  when "creator"
    stop = true
    mastermind.player_creator
  when "guesser"
    stop = true
    mastermind.player_guesser
  else
    puts "Please input creator or guesser"
  end
end

