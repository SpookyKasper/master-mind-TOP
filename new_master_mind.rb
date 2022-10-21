class Mastermind
  COLORS = %w[blue white green yellow orange cyan]
  TURNS = 12

  def initialize
    @solution = nil
    @current_guess = nil
    @current_feedback = nil
    @previous_guesses = []
    @previous_feedbacks = []
    @turns_left = TURNS
    @code_is_solved = false
    @gameover = false
  end

  def gen_color_combination
    combination = []
    4.times {combination << COLORS.sample}
    combination
  end

  def get_user(selection)
    puts "please input your #{selection}"
    gets.chomp.split
  end

  def get_feedback(guess, solution)
    solution_copy = solution.map {|v| v = v}
    feedback = []
    # guess.each_with_index do |color, index|
    #   if solution_copy.include?(color)
    #     i = solution_copy.index(color)
    #     guess[i] == solution_copy[i] || guess[index] == solution_copy[index] ? feedback << 2 : feedback << 1
    #     solution_copy[i] = "check"
    #   else
    #     feedback << 0
    #   end
    # end
    guess.each_with_index do |color, index|
      if solution_copy[index] == color then feedback << 2 and solution_copy[index] = "check" end
    end
    guess.each_with_index do |color, index|
      ind = solution_copy.index(color)
      if solution_copy.include?(color) then feedback << 1 and solution_copy[ind] = "check" end
    end
    until feedback.length == 4
      feedback << 0
    end
    feedback
  end

  def gen_guess_depending_on_feedback(guess, feedback)
    guess_copy = guess.map {|v| v = v}
    current_guess = []
    feedback.map.with_index do |num, index|
      case num
      when 0
        current_guess << COLORS.sample
      when 1
        current_guess << guess.sample
      when 2
        current_guess << guess[index]
      end
      guess_copy[index] = "check"
    end
    current_guess
  end

  def current_guess_passes_test?(current_guess, previous_guess, feedback)
    previous_copy = previous_guess.map {|v| v = v}
    exact = feedback.count(2)
    almost = feedback.count(1)
    nope = feedback.count(0)
    count_exact = 0
    count_almost = 0
    current_guess.each_with_index do |v, index|
      if previous_copy[index] == v
        count_exact += 1
        previous_copy[index] = "check"
      end
    end
    current_guess.each_with_index do |v, index|
      if previous_copy.include?(v)
        count_almost += 1
        previous_copy[previous_copy.index(v)] = "check"
      end
    end
    count_nope = previous_copy.count {|v| v != "check"}
    exact == count_exact && almost == count_almost && nope == nope
  end


  def guess
    if @previous_guesses.empty? then gen_color_combination
    else
      # fore every previous guess, new guess must pass the test
      # of fitting the feedback. for every 0, pick another color
      # for every 1, move a color, for every 2, same place same color
      turn = TURNS - @turns_left - 1
      guess = @previous_guesses[turn]
      feedback = @previous_feedbacks[turn]
      current_guess = gen_guess_depending_on_feedback(guess, feedback)
      # until current_guess_passes_test?(current_guess, guess, feedback)
      #   current_guess = gen_guess_depending_on_feedback(guess, feedback)
      # end
      current_guess
    end
  end

  def play_guesser
    @solution = gen_color_combination
    until @gameover
      @current_guess = get_user("guess")
      @current_feedback = get_feedback(@current_guess, @solution)
      @turns_left -= 1
      if @current_feedback.join == "2222" then @code_is_solved = true end
      if @turns_left == 0 || @code_is_solved then @gameover = true end
    end
  end

  def play_creator
    @solution = get_user("code")
    until @gameover
      @current_guess = guess
      @current_feedback = get_feedback(@current_guess, @solution)
      @previous_guesses << @current_guess
      @previous_feedbacks << @current_feedback
      @turns_left -= 1
      p @solution
      p @current_guess
      p @current_feedback
      if @current_feedback.join == "2222" then @code_is_solved = true end
      if @turns_left == 0 || @code_is_solved then @gameover = true end
    end
  end

end

my_game = Mastermind.new
my_game.play_creator
