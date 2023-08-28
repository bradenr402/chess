require_relative 'piece_icons'

class Piece
  include PieceIcons

  attr_accessor :color

  def initialize(color)
    @color = color
  end
end
