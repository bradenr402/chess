require_relative 'piece'
require_relative 'piece_icons'

class Pawn < Piece
  def to_s
    pawn_icon(@color)
  end

  def legal_moves(board, current_position)
    # implement pawn moving and capturing logic
  end
end
