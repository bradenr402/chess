class Player
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def to_s
    @color.to_s.capitalize
  end
end
