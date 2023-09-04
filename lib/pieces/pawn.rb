require_relative 'piece'
require_relative 'piece_icons'

class Pawn < Piece
  attr_accessor :has_moved, :en_passant_allowed

  def initialize(color)
    super
    @has_moved = false
    @en_passant_allowed = false
  end

  def to_s
    pawn_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    forward_moves = get_forward_moves(board, current_player, current_position)
    attacks = get_attacks(board, current_player, current_position)
    en_passant = @en_passant_allowed ? get_en_passant(board, current_player, current_position) : []

    forward_moves + attacks + en_passant
  end

  def get_forward_moves(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    forward_moves = []

    if current_player.color == :black
      square_in_front = board[x][y + 1]
      forward_moves << [x, y + 1] unless square_in_front.is_a?(Piece)

      two_squares_in_front = board[x][y + 2]
      forward_moves << [x, y + 2] unless @has_moved || square_in_front.is_a?(Piece) || two_squares_in_front.is_a?(Piece)
    else
      square_in_front = board[x][y - 1]
      forward_moves << [x, y - 1] unless square_in_front.is_a?(Piece)

      two_squares_in_front = board[x][y - 2]
      forward_moves << [x, y - 2] unless @has_moved || square_in_front.is_a?(Piece) || two_squares_in_front.is_a?(Piece)
    end

    forward_moves
  end

  def get_attacks(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    attacks = []

    if current_player.color == :black
      diagonal_left = board[x - 1][y + 1] unless x - 1 < 0
      attacks << [x - 1, y + 1] if !diagonal_left.nil? && diagonal_left.color == :white

      diagonal_right = board[x + 1][y + 1] unless x + 1 > 7
      attacks << [x + 1, y + 1] if !diagonal_right.nil? && diagonal_right.color == :white
    else
      diagonal_left = board[x - 1][y - 1] unless x - 1 < 0
      attacks << [x - 1, y - 1] if !diagonal_left.nil? && diagonal_left.color == :black

      diagonal_right = board[x + 1][y - 1] unless x + 1 > 7
      attacks << [x + 1, y - 1] if !diagonal_right.nil? && diagonal_right.color == :black
    end

    attacks
  end

  def get_en_passant(board, current_player, current_position)
    x = current_position.first
    y = current_position.last
    en_passant_attacks = []

    if current_player.color == :black
      unless x - 1 < 0
        en_passant_left = board[x - 1][y]
        en_passant_attacks << [x - 1, y + 1] if en_passant_left.color == :white
      end

      unless x + 1 > 7
        en_passant_right = board[x + 1][y]
        en_passant_attacks << [x + 1, y + 1] if en_passant_right.color == :white
      end
    else
      unless x - 1 < 0
        en_passant_left = board[x - 1][y]
        en_passant_attacks << [x - 1, y - 1] if en_passant_left.color == :black
      end

      unless x + 1 > 7
        en_passant_right = board[x + 1][y]
        en_passant_attacks << [x + 1, y - 1] if en_passant_right.color == :black
      end
    end

    en_passant_attacks
  end
end
