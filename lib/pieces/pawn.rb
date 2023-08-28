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
    all_moves = []
    if current_player.color == :black
      all_moves << [current_position[0], current_position[1] + 1]
      all_moves << [current_position[0], current_position[1] + 2] unless @has_moved
    else
      all_moves << [current_position[0], current_position[1] - 1]
      all_moves << [current_position[0], current_position[1] - 2] unless @has_moved
    end

    # add en passant movement

    all_moves

  end
end
