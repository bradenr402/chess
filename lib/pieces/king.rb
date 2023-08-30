require_relative 'piece'
require_relative 'piece_icons'

class King < Piece
  attr_accessor :has_moved

  def initialize(color)
    super
    @has_moved = false
  end

  def to_s
    king_icon(@color)
  end

  def legal_moves(board, current_player, current_position)
    moves = []

    (current_position.first - 1..current_position.first + 1).each do |x|
      (current_position.last - 1..current_position.last + 1).each do |y|
          moves << [x, y] if [x, y] != current_position && x.between?(0, 7) && y.between?(0, 7)
      end
    end

    # remove squares occupied by current player's piece
    moves.reject! { |square| board[square.first][square.last].color == current_player.color }

    # remove squares adjacent to opponent's king from moves
    remove_moves = remove_moves_next_to_king(board, current_player, current_position, moves)

    moves - remove_moves
  end

  def remove_moves_next_to_king(board, current_player, current_position, moves)
    illegal_moves = []

    moves.each do |square|
      adjacent_squares = []
      (square.first - 1..square.first + 1).each do |x|
        (square.last - 1..square.last + 1).each do |y|
          adjacent_squares << [x, y] if [x, y] != square && x.between?(0, 7) && y.between?(0, 7)
        end
      end
      if adjacent_squares.any? do |square|
          current_square = board[square.first][square.last]
          current_square.is_a?(King) && current_square.color != current_player.color && current_square.color != :none
        end
        illegal_moves << square
      end
    end

    illegal_moves
  end
end
