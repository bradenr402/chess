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
  LETTERS = ('a'..'h').to_a
  NUMBERS = (1..8).to_a

  def initialize
    @board = Array.new(8) { Array.new(8) }

    setup
    display
  end

  def display
    system("clear") # clears the terminal
    puts "\n   #{LETTERS.join('  ')}"
    i = 1
    bg_light = true
    @board.each do |row|
      print "#{i.to_s} "
      row.each do |piece|
        if piece.is_a?(Piece)
          if bg_light
            print piece.to_s.bg_gray
          else
            print piece.to_s.bg_black
          end
        else
          if bg_light
            print '   '.bg_gray
          else
            print '   '.bg_black
          end
        end
        bg_light = !bg_light
      end
      bg_light = !bg_light
      puts " #{i.to_s}"
      i += 1
    end
    puts "   #{LETTERS.join('  ')}\n\n"
  end

  def setup
    for i in (0..7)
      @board[6][i] = Pawn.new(:white, [6, i])
      @board[1][i] = Pawn.new(:black, [1, i])
    end

    @board[0][0] = Rook.new(:black, [0, 0])
    @board[0][7] = Rook.new(:black, [0, 7])
    @board[0][1] = Knight.new(:black, [0, 1])
    @board[0][6] = Knight.new(:black, [0, 6])
    @board[0][2] = Bishop.new(:black, [0, 2])
    @board[0][5] = Bishop.new(:black, [0, 5])
    @board[0][4] = King.new(:black, [0, 4])
    @board[0][3] = Queen.new(:black, [0, 3])

    @board[7][0] = Rook.new(:white, [7, 0])
    @board[7][7] = Rook.new(:white, [7, 7])
    @board[7][1] = Knight.new(:white, [7, 1])
    @board[7][6] = Knight.new(:white, [7, 6])
    @board[7][2] = Bishop.new(:white, [7, 2])
    @board[7][5] = Bishop.new(:white, [7, 5])
    @board[7][4] = King.new(:white, [7, 4])
    @board[7][3] = Queen.new(:white, [7, 3])
  end
end
