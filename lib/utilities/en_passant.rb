def attack_is_en_passant?(piece, start_position, end_position)
  [end_position] == piece.get_en_passant(@board.board, @current_player, start_position)
end

def allow_en_passant(piece, start_position, end_position)
  if piece.is_a?(Pawn) && (end_position.last - start_position.last == 2 || start_position.last - end_position.last == 2) # if pawn makes en passant move
    x = end_position.first
    y = end_position.last

    square_left = @board.board[x - 1][y] unless @board.board[x - 1].nil?
    if square_left.is_a?(Pawn) && square_left.color != @current_player.color
      square_left.en_passant_allowed = true
    end

    square_right = @board.board[x + 1][y] unless @board.board[x + 1].nil?
    if square_right.is_a?(Pawn) && square_right.color != @current_player.color
      square_right.en_passant_allowed = true
    end
  end
end

def disallow_all_en_passant
  @board.board.each do |row|
    row.each do |piece|
      if piece.is_a?(Pawn)
        piece.en_passant_allowed = false
      end
    end
  end
end
