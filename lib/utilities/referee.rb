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
  new_board = duplicate_board(@board.board)

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

def game_over?
  if checkmate?
    puts "Checkmate, #{@current_player}! #{@opponent} wins!"
    return true
  elsif stalemate?
    puts "Stalemate! Game over."
    return true
  end
  false
end

def threefold_repitition?
  current_board_state = duplicate_board(@board.board)

  @history.count { |board| boards_equal?(current_board_state, board) } >= 3
end

def boards_equal?(board1, board2)
  board1.each_with_index do |row, i|
    row.each_index do |j|
      return false unless board1[i][j].class == board2[i][j].class && board1[i][j].color == board2[i][j].color
    end
  end
  true
end

def claim_draw?
  loop do
    puts "    #{@current_player}, a threefold repitition has occurred. Would you like to claim a draw?"
    puts "    #{'[Y]'.green} Yes"
    puts "    #{'[N]'.red} No"
    choice = get_char
    return true if choice == 'Y' || choice == 'y'
    return false if choice == 'N' || choice == 'n'
  end
end