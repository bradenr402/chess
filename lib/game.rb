# require_relative 'board'
# require_relative 'pieces/piece'

class Game
  def initialize
    @board = Board.new
    @current_player = :white
  end

  def play_game
    loop do
      @board.display
      move = prompt_move
      break if move == 'quit'

      if move == 'save'
        # save game
        break
      end

      if legal_move?(move) && valid_move?(move)
        make_move(move)
        switch_player
      else
        puts "Invalid move. Try again."
      end
    end
  end

  def prompt_move
    print "#{@current_player.color.capitalize}, your move: "
    gets.chomp.downcase.split(' ') # returns move in format: ['xy', 'xy'], e.g. ['a1', 'b3']
  end

  def valid_move?(move)
    return false unless move.size == 2
    move.each do |coord|
      return false unless coord.size == 2 && ('a'..'h').include?(coord.split('')[0]) && ('1'..'8').include?(coord.split('')[1])
    end
    true
  end

  def legal_move?(move)
    # validate that the move is legal based on the current state of the board
      # i.e., the move is included in legal_moves (found in each Piece class)
    # legal_moves = [Piece].legal_moves
    # legal_moves.include?(move)
    # * make sure the formats match
  end

  def move_piece(move)
    #update the board based on the move
  end

  def switch_player
    @current_player = (@current_player == :white) ? :black : :white
  end

  def check?
    # detect if player's king is in check (probably at start of turn)
      # if true, restrict player's moves to escape check
      # if false, allow any legal moves
  end

  def checkmate?
    # detect checkmate by analyzing all possible moves
    # and determing if the king has no legal moves left
  end

  def stalemate?
    # detect stalemate
  end
end
