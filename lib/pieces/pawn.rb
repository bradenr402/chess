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

    if current_player.color == :black
      moves << [current_position.first, current_position.last + 1]
      moves << [current_position.first, current_position.last + 2] unless @has_moved
    else
      moves << [current_position.first, current_position.last - 1]
      moves << [current_position.first, current_position.last - 2] unless @has_moved
    end

    # add en passant movement

    moves

  end
end
