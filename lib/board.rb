# require_relative 'pieces/piece'
# require_relative 'pieces/piece_icons'
# require_relative 'pieces/pawn'
# require_relative 'pieces/rook'
# require_relative 'pieces/knight'
# require_relative 'pieces/bishop'
# require_relative 'pieces/king'
# require_relative 'pieces/queen'
# require_relative 'utilities/color'

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8, EmptySquare.new) }

    setup
  end

  def display
    system("clear") # clears the terminal
    puts "\n   a  b  c  d  e  f  g  h"
    i = 0
    bg_light = true
    while i < 8
      print "#{8 - i} "
      j = 0
      while j < 8
        if bg_light
          print @board[j][i].to_s.bg_gray
        else
          print @board[j][i].to_s.bg_black
        end
        j += 1
        bg_light = !bg_light
      end
      bg_light = !bg_light
      print " #{8 - i}\n"
      i += 1
    end
    puts "   a  b  c  d  e  f  g  h"
  end

  def setup
    for i in (0..7)
      @board[i][6] = Pawn.new(:white)
      @board[i][1] = Pawn.new(:black)
    end

    @board[0][7] = Rook.new(:white)
    @board[7][7] = Rook.new(:white)
    @board[1][7] = Knight.new(:white)
    @board[6][7] = Knight.new(:white)
    @board[2][7] = Bishop.new(:white)
    @board[5][7] = Bishop.new(:white)
    @board[4][7] = King.new(:white)
    @board[3][7] = Queen.new(:white)

    @board[0][0] = Rook.new(:black)
    @board[7][0] = Rook.new(:black)
    @board[1][0] = Knight.new(:black)
    @board[6][0] = Knight.new(:black)
    @board[2][0] = Bishop.new(:black)
    @board[5][0] = Bishop.new(:black)
    @board[4][0] = King.new(:black)
    @board[3][0] = Queen.new(:black)
  end
end
