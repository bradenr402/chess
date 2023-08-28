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

      move = format_move(move)

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
    gets.chomp
  end

  def format_move(move)
    move_hash = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7,
      '1' => 0,
      '2' => 1,
      '3' => 2,
      '4' => 3,
      '5' => 4,
      '6' => 5,
      '7' => 6,
      '8' => 7,
    }

    move = move.downcase.split('')
    move.delete(' ')

    move[0] = move_hash[move[0]]
    move[2] = move_hash[move[2]]

    move[1] = move[1].to_i - 1
    move[3] = move[3].to_i - 1

    move
  end

  def valid_move?(move)
    return false unless move.size == 4
    move.all? { |coord| coord.between?(0, 7) }
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
