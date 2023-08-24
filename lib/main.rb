require_relative 'game'
require_relative 'utilities/color'

def start_game
  loop do
    game = Game.new.play_game
    break unless play_again?
  end
end

def play_again?
  loop do
    puts 'Do you want to play again?'
    puts "#{'[1]'.green} Play another game"
    puts "#{'[2]'.red} Exit"
    input = gets.chomp
    return true if input == '1'
    return false if input == '2'
  end
end
