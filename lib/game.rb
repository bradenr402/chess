class Game
  def initialize
    @board = Chessboard.new
    @current_player = :white
  end

  def play_game
    loop do
      @board.display
      move = prompt_move
      break if move == 'quit'
      if valid_move?(move)
        make_move(move)
        switch_player
        # break
      else
        puts "Invalid move. Try again."
      end
    end
  end

  def prompt_move
    # prompt @current_player for a move
  end

  def valid_move?(move)
    # validate the move based on the current state of the board
  end

  def make_move(move)
    #update the board based on the move
  end

  def switch_player
    @current_player = (@current_player == :white) ? :black : :white
  end

  def check
    # detect if player's king is in check (probably at start of turn)
      # if true, restrict player's moves to escape check
    # detect checkmate by analyzing all possible moves and determing if the king has no legal moves left
  end
end
