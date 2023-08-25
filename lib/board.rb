require_relative 'pieces/piece'
require_relative 'pieces/piece_icons'
require_relative 'pieces/pawn'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'utilities/color'

class Board
  LETTERS = ('a'..'h').to_a
  NUMBERS = (1..8).to_a

  def initialize
    @board = Array.new(8) { Array.new(8) }

    setup
    display
  end

  def display
    puts "\n  " + " ".underline + LETTERS.join(' ').underline + " ".underline
    i = 1
    @board.each do |row|
      print i.to_s + '|'
      row.each do |piece|
        if piece.is_a?(Piece)
          print piece.to_s
        else
          print '  '
        end
      end
      print "\n"
      i += 1
    end
    puts "\n"
  end

  def setup
    for i in (0..7)
      @board[i][1] = Pawn.new(:white)
      @board[i][6] = Pawn.new(:black)
    end

    @board[0][0] = Rook.new(:white)
    @board[7][0] = Rook.new(:white)
    @board[1][0] = Knight.new(:white)
    @board[6][0] = Knight.new(:white)
    @board[2][0] = Bishop.new(:white)
    @board[5][0] = Bishop.new(:white)
    @board[3][0] = King.new(:white)
    @board[4][0] = Queen.new(:white)

    @board[0][7] = Rook.new(:black)
    @board[7][7] = Rook.new(:black)
    @board[1][7] = Knight.new(:black)
    @board[6][7] = Knight.new(:black)
    @board[2][7] = Bishop.new(:black)
    @board[5][7] = Bishop.new(:black)
    @board[3][7] = King.new(:black)
    @board[4][7] = Queen.new(:black)
  end
end
