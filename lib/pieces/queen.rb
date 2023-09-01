require_relative 'piece'
require_relative 'piece_icons'

class Queen < Piece
  def to_s
    queen_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    rook_moves = Rook.new(current_player.color).legal_moves(board, current_player, current_position)
    bishop_moves = Bishop.new(current_player.color).legal_moves(board, current_player, current_position)

    rook_moves + bishop_moves
  end
end
