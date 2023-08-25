require_relative 'piece'
require_relative 'piece_icons'

class King < Piece
  def to_s
    king_icon(@color)
  end

  def legal_moves(board, current_position)
    # implement king movement and capturing logic
  end
end
