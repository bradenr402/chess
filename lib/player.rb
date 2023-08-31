class Player
  attr_accessor :color, :castle_left_allowed, :castle_right_allowed

  def initialize(color)
    @color = color
    @castle_left_allowed = true
    @castle_right_allowed = true
  end

  def to_s
    @color.to_s.capitalize
  end
end
