# Unicode characters for each chess piece
# Formatted with a single white space on each side for proper formatting

require_relative '../utilities/color'
module PieceIcons
  def pawn_icon(color)
    if color == :white
      " \u2659 ".white
    else
      " \u265f ".black
    end
  end

  def rook_icon(color)
    if color == :white
      " \u2656 ".white
    else
      " \u265c ".black
    end
  end

  def knight_icon(color)
    if color == :white
      " \u2658 ".white
    else
      " \u265e ".black
    end
  end

  def bishop_icon(color)
    if color == :white
      " \u2657 ".white
    else
      " \u265d ".black
    end
  end

  def king_icon(color)
    if color == :white
      " \u2654 ".white
    else
      " \u265a ".black
    end
  end

  def queen_icon(color)
    if color == :white
      " \u2655 ".white
    else
      " \u265b ".black
    end
  end
end
