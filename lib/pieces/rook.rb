require_relative 'piece'
require_relative 'piece_icons'

class Rook < Piece
  attr_accessor :has_moved

  def initialize(color)
    super
    @has_moved = false
  end

  def to_s
    rook_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    moves = []

    x = current_position.first
    y = current_position.last

    until x == 7
      x += 1
      current_piece = board[x][y]
      moves << [x, y] unless current_piece.color == current_player.color
      break if current_piece.is_a?(Piece)
    end
    x = current_position.first

    until x == 0
      x -= 1
      current_piece = board[x][y]
      moves << [x, y] unless current_piece.color == current_player.color
      break if current_piece.is_a?(Piece)
    end
    x = current_position.first

    until y == 7
      y += 1
      current_piece = board[x][y]
      moves << [x, y] unless current_piece.color == current_player.color
      break if current_piece.is_a?(Piece)
    end
    y = current_position.last

    until y == 0
      y -= 1
      current_piece = board[x][y]
      moves << [x, y] unless current_piece.color == current_player.color
      break if current_piece.is_a?(Piece)
    end

    moves
  end
end
