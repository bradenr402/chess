require_relative 'piece_icons'

class Piece
  include PieceIcons

  def initialize(color, position)
    @color = color
    @position = position
  end

  def legal_moves(board, current_position)
    # implement piece-specific movement logic
      # return array of legal_moves
    # ? better to include this in each child of Piece instead of here?
  end
end
