require_relative 'piece'
require_relative 'piece_icons'

class King < Piece
  def to_s
    king_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    all_moves = []
    
    (current_position[0] - 1..current_position[0] + 1).each do |x|
      (current_position[1] - 1..current_position[1] + 1).each do |y|
          all_moves << [x, y] if [x, y] != current_position && x.between?(0, 7) && y.between?(0, 7)
      end
    end

    all_moves.each do |square|
      current_square = board.board[square[0]][square[1]]
      if current_square.color == current_player.color
        all_moves.delete(square)
      end
    end

    # remove move if square is adjacent to opponent's king
    all_moves.each do |square|
      adjacent_squares = []
      (square[0] - 1..square[0] + 1).each do |x|
        (square[1] - 1..square[1] + 1).each do |y|
          adjacent_squares << [x, y] if [x, y] != square && x.between?(0, 7) && y.between?(0, 7)
        end
      end
      if adjacent_squares.any? do |square|
          current_square = board.board[square[0]][square[1]]
          current_square.is_a?(King) && current_square.color != current_player.color && current_square.color != :none
        end
        all_moves.delete(square)
      end
    end

    all_moves
  end
end
