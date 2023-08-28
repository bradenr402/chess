class EmptySquare
  attr_reader :color

  def initialize
    @color = :none
  end

  def to_s
    '   '
  end
end
