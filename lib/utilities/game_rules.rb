def title_art
  <<-TEXT

  Welcome to...
  ███████  ██   ██  ███████  ███████  ███████  ██
  ██   ██  ██   ██  ██       ██       ██       ██
  ██       ███████  █████    ███████  ███████  ██
  ██   ██  ██   ██  ██            ██       ██
  ███████  ██   ██  ███████  ███████  ███████  ██

  TEXT
end

def how_to_play
  <<-TEXT
  #{'HOW TO PLAY'.bold.blue}
  To select a move, type the square you want to move from
  followed by the square you want to move to.
    #{'EXAMPLES'.bold.green}
      a2 a4
      d3 c5
      h5 c5
    The space is optional, so you can also type the above examples like this:
    #{'EXAMPLES'.bold.green}
      a2a4
      d3c5
      h5c5

  #{'En passant'.bold} moves are entered with the same notation, with the pawn's ending point as the destination.
  #{'Castle'.bold} moves are entered as either '#{'castle left'.italic}' or '#{'castle right'.italic}.'
    #{'Castling is from the perspective of the white player.'.white.bold}
      So 'a1' is the starting square of the 'left' rook for white,
      and 'a8' is the starting square of the 'left' rook for black.

  #{'COMMANDS'.bold.blue}
    #{'help'.bold.green} - Display this screen again.
    #{'save'.bold.green} - Save and exit the game.
    #{'exit'.bold.green} - Exit the game without saving.

  TEXT
end

def introduction
  system('clear')
  puts title_art
  print "    Press any key to continue: ".green
  get_char

  system('clear')
  puts how_to_play
  print "    Press any key to begin!\n    ".green
  get_char

  system('clear')
  @board.display
end
