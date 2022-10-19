
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



