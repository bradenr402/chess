require_relative 'piece_icons'

class Piece
  include PieceIcons
  
  def initialize(color)
    @color = color
  end

  def legal_moves(board, current_position)
    # implement piece-specific movement logic
  end
end
