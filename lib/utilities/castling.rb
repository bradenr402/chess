def castle_allowed?(move)
  return false if check?

  if move == 'castle left'
    if @current_player.color == :black
      return @current_player.castle_left_allowed &&
              @board.board[1][0].is_a?(EmptySquare) &&
              @board.board[2][0].is_a?(EmptySquare) &&
              @board.board[3][0].is_a?(EmptySquare) &&
              square_is_safe?([2, 0]) &&
              square_is_safe?([3, 0])
    else
      return @current_player.castle_left_allowed &&
              @board.board[1][7].is_a?(EmptySquare) &&
              @board.board[2][7].is_a?(EmptySquare) &&
              @board.board[3][7].is_a?(EmptySquare) &&
              square_is_safe?([2, 7]) &&
              square_is_safe?([3, 7])
    end
  elsif move == 'castle right'
    if @current_player.color == :black
      return @current_player.castle_right_allowed &&
              @board.board[5][0].is_a?(EmptySquare) &&
              @board.board[6][0].is_a?(EmptySquare) &&
              square_is_safe?([5, 0]) &&
              square_is_safe?([6, 0])
    else
      return @current_player.castle_right_allowed &&
              @board.board[5][7].is_a?(EmptySquare) &&
              @board.board[6][7].is_a?(EmptySquare) &&
              square_is_safe?([5, 7]) &&
              square_is_safe?([6, 7])
    end
  end
end

def castle_left
  if @current_player.color == :black
    rook = @board.board[0][0]
    king = @board.board[4][0]

    @board.board[3][0] = rook
    @board.board[0][0] = EmptySquare.new

    @board.board[2][0] = king
    @board.board[4][0] = EmptySquare.new
  else
    rook = @board.board[0][7]
    king = @board.board[4][7]

    @board.board[3][7] = rook
    @board.board[0][7] = EmptySquare.new

    @board.board[2][7] = king
    @board.board[4][7] = EmptySquare.new
  end
end

def castle_right
  if @current_player.color == :black
    rook = @board.board[7][0]
    king = @board.board[4][0]

    @board.board[5][0] = rook
    @board.board[7][0] = EmptySquare.new

    @board.board[6][0] = king
    @board.board[4][0] = EmptySquare.new
  else
    rook = @board.board[7][7]
    king = @board.board[4][7]

    @board.board[5][7] = rook
    @board.board[7][7] = EmptySquare.new

    @board.board[6][7] = king
    @board.board[4][7] = EmptySquare.new
  end
end

def update_castle_allowed(piece, start_position, end_position)
  if piece.is_a?(King)
    @current_player.castle_left_allowed = false
    @current_player.castle_right_allowed = false
  elsif piece.is_a?(Rook)
    @current_player.castle_left_allowed = false if start_position == [0, 0] || start_position == [7, 0]
    @current_player.castle_right_allowed = false if start_position == [0, 7] || start_position == [7, 7]
  end
end

