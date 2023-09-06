def square_is_safe?(square)
  @board.board.each_with_index do |row, i|
    row.each_with_index do |piece, j|
      square_position = [i, j]
      if piece.color == @opponent.color
        legal_moves = piece.legal_moves(@board.board, @opponent, square_position)
        return false if legal_moves.include?(square)
      end
    end
  end
  true
end

def check?(board = @board.board)
  king_position = []
  board.each_with_index do |row, i|
    row.each_with_index do |square, j|
      king_position = [i, j] if square.is_a?(King) && square.color == @current_player.color
    end
  end

  board.each_with_index do |row, i|
    row.each_with_index do |square, j|
      square_position = [i, j]
      if square.color == @opponent.color
        legal_moves = square.legal_moves(board, @opponent, square_position)
        return true if legal_moves.include?(king_position)
      end
    end
  end
  false
end

def escapes_check?(move)
  new_board = Array.new(8) { Array.new(8, EmptySquare.new) }

  @board.board.each_with_index do |row, i|
    row.each_with_index do |square, j|
      square_class = square.class
      if square.is_a?(Piece)
        new_board[i][j] = square_class.new(square.color)
      end
    end
  end

  new_board = move_piece(move, new_board)

  !check?(new_board)
end

def checkmate?(board = @board.board)
  return false unless check?

  board.each_with_index do |row, i|
    row.each_with_index do |square, j|
      square_position = [i, j]
      if square.color == @current_player.color
        legal_moves = square.legal_moves(board, @current_player, square_position)
        legal_moves.map! { |move| square_position + move }
        return false if legal_moves.any? { |move| escapes_check?(move) }
      end
    end
  end
  true
end

def stalemate?(board = @board.board)
  possible_moves = []

  board.each_with_index do |row, i|
    row.each_with_index do |square, j|
      square_position = [i, j]
      if square.color == @current_player.color
        legal_moves = square.legal_moves(board, @current_player, square_position)
        legal_moves.each do |move|
          possible_moves << move if legal_move?(square_position + move)
        end
      end
    end
  end
  possible_moves.empty?
end
