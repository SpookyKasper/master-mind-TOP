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

# declare an array with the inital letter of the colors
colors = %w(y o p b w c)

# make the computer generate a random code based on the six possible colors
code_to_find = colors.sample(4)

puts "Hello player! what is your buest guess for this mastermind game?"
puts "Here are the 6 available colors"
p "Yellow"
p "Orange"
p "Blue"
p "White"
p "Cyan"
p "Green"
puts "Please make your guess using a combination of 4 colors"
puts "Please use the initals of the colors to make your guess"
puts "Example: WBOY for White Blue Orange Yellow"
puts "Example 2: CYOG for Cyan Yellow Orange Green"
puts "Let's go!"


board = Array.new(12) {Array.new(4)}

board.each do |v|
  p v
end



