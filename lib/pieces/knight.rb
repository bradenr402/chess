require_relative 'piece'
require_relative 'piece_icons'

class Knight < Piece
  MOVES = [[1, 2], [-1, -2], [-1, 2], [1, -2], [2, 1], [-2, -1], [-2, 1], [2, -1]]

  def to_s
    knight_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    moves = []

    MOVES.each do |move|
      if (current_position.first + move.first).between?(0, 7) && (current_position.last + move.last).between?(0, 7)
        moves << [current_position.first + move.first, current_position.last + move.last]
      end
    end

    # remove squares occupied by current player's piece
    moves.reject! { |square| board[square.first][square.last].color == current_player.color }

    moves
  end
end
