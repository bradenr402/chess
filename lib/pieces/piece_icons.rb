# Unicode characters for each chess piece
# Formatted with a single white space on each side for proper formatting

require_relative '../utilities/color'
module PieceIcons
  def pawn_icon(color)
    if color == :white
      " \u265f".white
    else
      " \u265f".black
    end
  end

  def rook_icon(color)
    if color == :white
      " \u265c".white
    else
      " \u265c".black
    end
  end

  def knight_icon(color)
    if color == :white
      " \u265e".white
    else
      " \u265e".black
    end
  end

  def bishop_icon(color)
    if color == :white
      " \u265d".white
    else
      " \u265d".black
    end
  end

  def king_icon(color)
    if color == :white
      " \u265a".white
    else
      " \u265a".black
    end
  end

  def queen_icon(color)
    if color == :white
      " \u265b".white
    else
      " \u265b".black
    end
  end
end
