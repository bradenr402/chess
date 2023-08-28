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

  LETTERS = ('a'..'h').to_a
  NUMBERS = (1..8).to_a

  def initialize
    @board = Array.new(8) { Array.new(8, EmptySquare.new) }

    setup
  end

  def display
    system("clear") # clears the terminal
    puts "\n   #{LETTERS.join('  ')}"
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
    puts "   #{LETTERS.join('  ')}"
  end

  def setup
    for i in (0..7)
      @board[i][6] = Pawn.new(:white, [i, 6])
      @board[i][1] = Pawn.new(:black, [i, 1])
    end

    @board[0][7] = Rook.new(:white, [0, 7])
    @board[7][7] = Rook.new(:white, [7, 7])
    @board[1][7] = Knight.new(:white, [1, 7])
    @board[6][7] = Knight.new(:white, [6, 7])
    @board[2][7] = Bishop.new(:white, [2, 7])
    @board[5][7] = Bishop.new(:white, [5, 7])
    @board[4][7] = King.new(:white, [4, 7])
    @board[3][7] = Queen.new(:white, [3, 7])

    @board[0][0] = Rook.new(:black, [0, 0])
    @board[7][0] = Rook.new(:black, [7, 0])
    @board[1][0] = Knight.new(:black, [1, 0])
    @board[6][0] = Knight.new(:black, [6, 0])
    @board[2][0] = Bishop.new(:black, [2, 0])
    @board[5][0] = Bishop.new(:black, [5, 0])
    @board[4][0] = King.new(:black, [4, 0])
    @board[3][0] = Queen.new(:black, [3, 0])
  end
end
