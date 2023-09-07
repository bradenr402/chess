require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'empty_square'

require_relative 'pieces/piece'
require_relative 'pieces/piece_icons'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/queen'

require_relative 'utilities/color'
require_relative 'utilities/save_load'
require_relative 'utilities/get_char'
require_relative 'utilities/game_rules'
require_relative 'utilities/castling'
require_relative 'utilities/promotion'
require_relative 'utilities/en_passant'
require_relative 'utilities/referee'
require 'pry-byebug'

def start_game
  loop do
    system('clear')
    puts title_art
    @game = choose_game
    result = @game.play_game
    if result == 'save'
      save_game(@game)
      next
    elsif result == 'menu'
      next
    end
    break unless play_again?
  end
end

def choose_game
  puts '  What would you like to do?'
  puts "    #{'[N]'.blue} Start new game"
  puts "    #{'[L]'.green} Load saved game"
  puts "    #{'[E]'.red} Exit"
  choice = get_char

  case choice
  when 'N', 'n'
    return new_game
  when 'L', 'l'
    return load_game
  when 'E', 'e'
    exit
  else
    choose_game
  end
end

def play_again?
  loop do
    puts '  Do you want to play again?'
    puts "    #{'[Y]'.green} Play again"
    puts "    #{'[N]'.red} Exit"
    input = get_char
    return true if input == 'Y' || input == 'y'
    return false if input == 'N' || input == 'n'
  end
end

start_game
