require_relative 'piece'
require_relative 'piece_icons'

class Pawn < Piece
  attr_accessor :has_moved

  def initialize(color)
    super
    @has_moved = false
  end

  def to_s
    pawn_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    moves = []

    # add forward movement
    forward_moves = get_forward_moves(board, current_player, current_position, moves)

    # add attack movement
    attacks = get_attacks(board, current_player, current_position, moves)

    # add en passant movement

    forward_moves + attacks
  end

  def get_forward_moves(board, current_player, current_position, moves)
    forward_moves = moves

    if current_player.color == :black
      square_in_front = board[current_position.first][current_position.last + 1]
      forward_moves << [current_position.first, current_position.last + 1] unless square_in_front.is_a?(Piece)

      two_squares_in_front = board[current_position.first][current_position.last + 2]
      forward_moves << [current_position.first, current_position.last + 2] unless @has_moved || two_squares_in_front.is_a?(Piece)
    else
      square_in_front = board[current_position.first][current_position.last - 1]
      forward_moves << [current_position.first, current_position.last - 1] unless square_in_front.is_a?(Piece)

      two_squares_in_front = board[current_position.first][current_position.last - 2]
      forward_moves << [current_position.first, current_position.last - 2] unless @has_moved || two_squares_in_front.is_a?(Piece)
    end

    forward_moves
  end

  def get_attacks(board, current_player, current_position, moves)
    attacks = moves

    if current_player.color == :black
      diagonal_left = board[current_position.first - 1][current_position.last + 1]
      attacks << [current_position.first - 1, current_position.last + 1] if diagonal_left.color == :white

      diagonal_right = board[current_position.first + 1][current_position.last + 1]
      attacks << [current_position.first + 1, current_position.last + 1] if diagonal_right.color == :white
    else
      diagonal_left = board[current_position.first - 1][current_position.last - 1]
      attacks << [current_position.first - 1, current_position.last - 1] if diagonal_left.color == :black

      diagonal_right = board[current_position.first + 1][current_position.last - 1]
      attacks << [current_position.first + 1, current_position.last - 1] if diagonal_right.color == :black
    end

    attacks
  end
end
