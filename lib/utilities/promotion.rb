def pawn_at_opposite_side?(pawn, end_position)
  if pawn.color == :black
    return end_position.last == 7
  elsif pawn.color == :white
    return end_position.last == 0
  end
  false
end

def promote(pawn)
  selection = choose_promotion
  case selection
  when 'Q', 'q'
    return Queen.new(pawn.color)
  when 'R', 'r'
    return Rook.new(pawn.color)
  when 'B', 'b'
    return Bishop.new(pawn.color)
  when 'K', 'k'
    return Knight.new(pawn.color)
  else
    promote(pawn)
  end
end

def choose_promotion
  puts "Choose a piece to promote your pawn to:"
  puts "#{'[Q]'.green} Queen"
  puts "#{'[R]'.blue} Rook"
  puts "#{'[B]'.green} Bishop"
  puts "#{'[K]'.magenta} Knight"
  get_char
end
