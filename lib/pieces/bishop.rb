require_relative 'piece'
require_relative 'piece_icons'

class Bishop < Piece
  def to_s
    bishop_icon(@color)
  end

  def legal_moves(board, current_position)
    # implement bishop movement and capturing logic
  end
end
