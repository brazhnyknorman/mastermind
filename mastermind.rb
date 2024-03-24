$COLORS = ["red", "blue", "yellow", "white", "black", "white"]

module Hintable
  def give_hint(code) # Feed the code from the code master
    @@almost_right = 0
    @@right = 0
    
    @guess.each_with_index do |value,index|
      if @guess[index] == code[index]
        @@right += 1
      elsif code.include?(guess[index])
        @@almost_right +=1
      end
    end
     if self.class == Player
       puts "\n\nThere are #{@@right} elements and #{@@almost_right} misplaced elements in your guess."
     elsif self.class == Computer
     end
  end
end

module Checkable
  def correct_guess?(guess)
    @code == guess
  end
end

class Mastermind
  #@games_to_play
  #@game_state
  attr_accessor :games_to_play, :game_state

  def initialize
    @game_state = nil
    @games_to_play = nil
  end
  
  def start_game
    print "Enter Y to play as the Code Breaker.\nEnter N to play as the Code Master.\nEnter: "
    @game_state = gets.upcase.chomp

    print "\nAnd how many games will you play: "
    @games_to_play = gets.to_i
  end

  def reset_game
  end

  def end_program
  end
end

class Player
  #@guess_count
  #@code_master_score
  #@code
  #@guess
  include Hintable
  include Checkable

  attr_accessor :guess_count,:code_master_score,:code, :guess

  def initialize
    @guess_count = 0
    @code_master_score = 0
    @code = nil
    @guess = nil
  end

  def set_code
  end

  def take_guess
    print "Enter your guess (ex. 'red blue red green'): "
    @guess = gets.downcase.split(" ")
  end

end

class Computer
  #@guess_count
  #@code_master_score
  #@code
  include Hintable
  include Checkable

  attr_accessor :guess_count,:code_master_score,:code

  def initialize
    @guess_count = 0
    @code_master_score = 0
    @code = []
  end

  def set_code
    4.times do |i=0|
      @code[i] = $COLORS[rand(0..5)]
    end
    p @code
  end

  def take_guess
  end

end

game = Mastermind.new
player = Player.new
bot = Computer.new

game.start_game

game.games_to_play.times {
  case game.game_state
    when "Y" #Code Breaker
      bot.set_code

      10.times {
        bot.code_master_score += 1
        player.take_guess
        
        if bot.correct_guess?(player.guess) == false
          player.give_hint(bot.code)
        elsif bot.correct_guess?(player.guess) == true
          puts "Your current total codemaster score is #{player.code_master_score}."
          puts "The computer's total codemaster score is #{bot.code_master_score}"
        end

        break if bot.correct_guess?(player.guess) == true
      }
    when "N" #Code Master
  else
    puts "Please input your options correctly, please."
    exit
  end
}