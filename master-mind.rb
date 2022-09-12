=begin
begin pseudo code:

Build the game assuming the computer randomly selects the secret colors
and the human player must guess them. Remember that you need to give the
proper feedback on how good the guess was each turn!


make the computer generate a random code of 4 letters (first letter of a color)
from a collection of 6 letters

tell the player what are is options and ask the player to input is guess,
compare it to the computer code and give a feedback to the user
on how accurate is guess was

display:

make 12 rows of 2 arrays of 4 slots each, one is for the player to
guess, the other one is for the feedback of the computer.
the array of the feedback shows 0 if the color is not present in the
code, 1 if the color is present but it the wrong spot and 2 if
the color is present and in the right spot

Yellow
Orange
Purple
Blue
White
Cyan
=end

# display some explanation for the player
puts "Hello player! what is your buest guess for this mastermind game?"
puts "Please make your guess using a combination of 4 colors seperated with spaces"
puts "Example: Green yellow blue white"
puts "Or: cyan white blue orange"
puts "You have 12 tries, good luck!"
puts "Let's go!"

# declare an array with the colors available
colors = %w(yellow orange purple blue white cyan)

# make the computer generate a random code based on the six possible colors
code_to_find = colors.sample(4)

# # declare a board made of arrays with nil elements and print it
# board = Array.new(12) {Array.new(4)}
# board.each do |v|
#   p v
# end

# make a loop that keeps asking for user guesses until they got the code or until
# they run out of guesses
time_to_stop = false
player_found_code = false
guesses_left = 12
until (time_to_stop)
  if guesses_left < 12
    puts "Not yet! try again! you have #{guesses_left} guesses left!"
  end
  puts "Remember, the possible colors are: #{colors}"
  puts "So darling what is your guess ?"
  guess = gets.chomp.downcase.split
  # compare guess and code to find
  feedback_array = []
  guess.each_with_index do |color, index|
    if code_to_find.index(color) == index then feedback_array << 2
    elsif code_to_find.include?(color) && code_to_find.index(color) != index then feedback_array << 1
    else feedback_array << 0
    end
  end
  p guess
  p code_to_find
  p feedback_array.shuffle
  if feedback_array.join == '2222'
    puts "Congratulations, you cracked the code!"
    time_to_stop = true
  end
  guesses_left -= 1
  if guesses_left == 0 then time_to_stop = true end
end


