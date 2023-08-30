require_relative 'piece'
require_relative 'piece_icons'

class Queen < Piece
  def to_s
    queen_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    # implement queen movement and capturing logic
    # * shortcut: queen's moves = rook's moves + bishop's moves

    rook = Rook.new(current_player.color)
    bishop = Bishop.new(current_player.color)

    moves = []
    rook_moves = rook.legal_moves(board, current_player, current_position)
    bishop_moves = bishop.legal_moves(board, current_player, current_position)

    rook_moves + bishop_moves
  end
end
