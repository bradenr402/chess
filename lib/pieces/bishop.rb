require_relative 'piece'
require_relative 'piece_icons'

class Bishop < Piece
  def to_s
    bishop_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    # implement bishop movement and capturing logic

    moves = []

    x = current_position.first
    y = current_position.last

    until x == 7 || y == 7
      x += 1
      y += 1
      current_piece = board[x][y]
      moves << [x, y] unless current_piece.color == current_player.color
      break if current_piece.is_a?(Piece)
    end
    x = current_position.first
    y = current_position.last

    until x == 7 || y == 0
      x += 1
      y -= 1
      current_piece = board[x][y]
      moves << [x, y] unless current_piece.color == current_player.color
      break if current_piece.is_a?(Piece)
    end
    x = current_position.first
    y = current_position.last

    until x == 0 || y == 7
      x -= 1
      y += 1
      current_piece = board[x][y]
      moves << [x, y] unless current_piece.color == current_player.color
      break if current_piece.is_a?(Piece)
    end
    x = current_position.first
    y = current_position.last

    until x == 0 || y == 0
      x -= 1
      y -= 1
      current_piece = board[x][y]
      moves << [x, y] unless current_piece.color == current_player.color
      break if current_piece.is_a?(Piece)
    end

    moves
  end
end
