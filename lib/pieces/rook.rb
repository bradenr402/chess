require_relative 'piece'
require_relative 'piece_icons'

class Rook < Piece
  def to_s
    rook_icon(@color)
  end

  def legal_moves(board, current_position)
    # implement rook movement and capturing logic
  end
end
