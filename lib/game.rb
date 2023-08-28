# require_relative 'board'
# require_relative 'pieces/piece'

class Game
  def initialize
    @board = Board.new
    @current_player = Player.new(:white)
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

      # binding.pry

      move = format_move(move)

      if valid_move?(move) && legal_move?(move)
        move_piece(move)
        switch_player
      else
        puts "Invalid move. Try again."
      end
    end
  end

  def prompt_move
    print "#{@current_player}, your move: "
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
      'h' => 7
    }

    move = move.downcase.split('')
    move.delete(' ')

    move[0] = move_hash[move[0]]
    move[2] = move_hash[move[2]]

    move[1] = 8 - move[1].to_i
    move[3] = 8 - move[3].to_i

    move
  end

  def valid_move?(move)
    return false unless move.size == 4
    return false if move.any? { |coord| coord.nil? }

    start_position = move.first(2)
    square = @board.board[start_position[0]][start_position[1]]
    return false unless square.is_a?(Piece) && square.color == @current_player.color

    move.all? { |coord| coord.between?(0, 7) }
  end

  def legal_move?(move)
    start_position = move.first(2)
    end_position = move.last(2)
    current_piece = @board.board[start_position[0]][start_position[1]]
    legal_moves = current_piece.legal_moves(@board, @current_player, start_position)

    destination_square = @board.board[end_position[0]][end_position[1]]
    return false if destination_square.is_a?(Piece) && destination_square.color == @current_player.color

    legal_moves.include?(end_position)
  end

  def move_piece(move)
    # update the board based on the move

    start_position = move.first(2)
    end_position = move.last(2)

    piece = @board.board[start_position[0]][start_position[1]]

    @board.board[end_position[0]][end_position[1]] = piece
    @board.board[start_position[0]][start_position[1]] = EmptySquare.new

    piece.has_moved = true if piece.is_a?(Pawn)
  end

  def switch_player
    @current_player.color = (@current_player.color == :white) ? :black : :white
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
