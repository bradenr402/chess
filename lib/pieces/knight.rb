require_relative 'piece'
require_relative 'piece_icons'

class Knight < Piece
  MOVES = [[1, 2], [-1, -2], [-1, 2], [1, -2], [2, 1], [-2, -1], [-2, 1], [2, -1]]

  def to_s
    knight_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves = []

    MOVES.each do |move|
      if (x + move.first).between?(0, 7) && (y + move.last).between?(0, 7)
        moves << [x + move.first, y + move.last] unless board[x + move.first][y + move.last].color == current_player.color
      end
    end

    moves
  end
end
