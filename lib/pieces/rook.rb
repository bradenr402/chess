require_relative 'piece'
require_relative 'piece_icons'

class Rook < Piece
  def to_s
    rook_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    moves = []

    moves_right = get_moves_right(board, current_player, current_position)
    moves_left = get_moves_left(board, current_player, current_position)
    moves_down = get_moves_down(board, current_player, current_position)
    moves_up = get_moves_up(board, current_player, current_position)

    moves_right + moves_left + moves_up + moves_down
  end

  def get_moves_left(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves_left = []

    until x == 0
      x -= 1
      current_square = board[x][y]
      moves_left << [x, y] unless current_square.color == current_player.color
      break if current_square.is_a?(Piece)
    end

    moves_left
  end

  def get_moves_right(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves_right = []

    until x == 7
      x += 1
      current_square = board[x][y]
      moves_right << [x, y] unless current_square.color == current_player.color
      break if current_square.is_a?(Piece)
    end

    moves_right
  end

  def get_moves_up(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves_up = []

    until y == 0
      y -= 1
      current_square = board[x][y]
      moves_up << [x, y] unless current_square.color == current_player.color
      break if current_square.is_a?(Piece)
    end

    moves_up
  end

  def get_moves_down(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves_down = []

    until y == 7
      y += 1
      current_square = board[x][y]
      moves_down << [x, y] unless current_square.color == current_player.color
      break if current_square.is_a?(Piece)
    end

    moves_down
  end
end
