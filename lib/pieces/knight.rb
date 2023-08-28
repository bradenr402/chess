require_relative 'piece'
require_relative 'piece_icons'

class Knight < Piece
  MOVES = [[1, 2], [-1, -2], [-1, 2], [1, -2], [2, 1], [-2, -1], [-2, 1], [2, -1]]

  def to_s
    knight_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    all_moves = []

    MOVES.each do |move|
      if (current_position[0] + move[0]).between?(0, 7) && (current_position[1] + move[1]).between?(0, 7)
        all_moves << [current_position[0] + move[0], current_position[1] + move[1]]
      end
    end

    all_moves.each do |square|
      current_square = board.board[square[0]][square[1]]
      if current_square.is_a?(Piece) && current_square.color == current_player.color
        all_moves.delete(square)
      end
    end

    all_moves
  end
end
