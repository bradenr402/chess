require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'utilities/color'
require_relative 'utilities/save_load'
require_relative 'pieces/piece'
require_relative 'pieces/piece_icons'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'empty_square'
require_relative 'utilities/get_char'

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

include GetChar
require "pry-byebug"
start_game
