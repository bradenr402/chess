require_relative 'piece'
require_relative 'piece_icons'

class King < Piece
  def to_s
    king_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    moves = []

    (current_position.first - 1..current_position.first + 1).each do |x|
      (current_position.last - 1..current_position.last + 1).each do |y|
          moves << [x, y] if [x, y] != current_position && x.between?(0, 7) && y.between?(0, 7)
      end
    end

    moves.reject! { |square| board[square.first][square.last].color == current_player.color }

    # remove move if square is adjacent to opponent's king
    moves.each do |square|
      adjacent_squares = []
      (square.first - 1..square.first + 1).each do |x|
        (square.last - 1..square.last + 1).each do |y|
          adjacent_squares << [x, y] if [x, y] != square && x.between?(0, 7) && y.between?(0, 7)
        end
      end
      if adjacent_squares.any? do |square|
          current_square = board[square.first][square.last]
          current_square.is_a?(King) && current_square.color != current_player.color && current_square.color != :none
        end
        moves.delete(square)
      end
    end

    moves
  end
end
