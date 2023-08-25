require_relative 'piece'
require_relative 'piece_icons'

class Knight < Piece
  def to_s
    knight_icon(@color)
  end

  def legal_moves(board, current_position)
    # implement knight movement and capturing logic

    # refer to Knights Travails project
  end
end
