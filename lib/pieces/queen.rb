require_relative 'piece'
require_relative 'piece_icons'

class Queen < Piece
  def to_s
    queen_icon(@color)
  end

  def legal_moves(board, current_position)
    # implement queen movement and capturing logic
  end
end
