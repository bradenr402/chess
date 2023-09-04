require_relative 'piece'
require_relative 'piece_icons'

class Bishop < Piece
  def to_s
    bishop_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    moves_right_down = get_moves_right_down(board, current_player, current_position)
    moves_left_down = get_moves_left_down(board, current_player, current_position)
    moves_right_up = get_moves_right_up(board, current_player, current_position)
    moves_left_up = get_moves_left_up(board, current_player, current_position)

    moves_right_down + moves_left_down + moves_right_up + moves_left_up
  end

  def get_moves_left_up(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves = []

    loop do
      x -= 1
      y -= 1
      break if x < 0 || y < 0

      current_square = board[x][y]
      moves << [x, y] unless current_square.color == current_player.color
      break if current_square.is_a?(Piece)
    end

    moves
  end

  def get_moves_right_up(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves = []

    loop do
      x += 1
      y -= 1
      break if x > 7 || y < 0

      current_square = board[x][y]
      moves << [x, y] unless current_square.color == current_player.color
      break if current_square.is_a?(Piece)
    end

    moves
  end

  def get_moves_left_down(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves = []

    loop do
      x -= 1
      y += 1
      break if x < 0 || y > 7

      current_square = board[x][y]
      moves << [x, y] unless current_square.color == current_player.color
      break if current_square.is_a?(Piece)
    end

    moves
  end

  def get_moves_right_down(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    moves = []

    loop do
      x += 1
      y += 1
      break if x > 7 || y > 7

      current_square = board[x][y]
      moves << [x, y] unless current_square.color == current_player.color
      break if current_square.is_a?(Piece)
    end

    moves
  end
end
