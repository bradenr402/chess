class Game
  def initialize
    @board = Board.new
    @current_player = Player.new(:white)
  end

  def play_game
    introduction
    blank_line = true
    loop do
      puts "\n" if blank_line
      move = prompt_move

      if move == 'help'
        system('clear')
        puts how_to_play
        print "    Press any key to continue: ".green
        get_char

        system('clear')
        @board.display
        next
      elsif move == 'save'
        # save game
        break
      end

      break if move == 'exit'

      move = format_move(move) unless move.include?('castle')

      if valid_move?(move) && legal_move?(move)
        move_piece(move)
        switch_player
      else
        puts "Invalid move. Try again."
      end
      blank_line = true

      switch_player
      system('clear')
      @board.display
    end
  end

  def prompt_move
    print "    #{@current_player}, your move: "
    gets.chomp
  end

  def format_move(move)
    move_hash = {
      'a' => 0,
      'b' => 1,
      'c' => 2,
      'd' => 3,
      'e' => 4,
      'f' => 5,
      'g' => 6,
      'h' => 7
    }

    move = move.downcase.split('')
    move.delete(' ')

    move[0] = move_hash[move[0]]
    move[2] = move_hash[move[2]]

    move[1] = 8 - move[1].to_i
    move[3] = 8 - move[3].to_i

    move
  end

  def valid_move?(move)
    return false unless move.size == 4
    return false if move.any? { |coord| coord.nil? }

    start_position = move.first(2)
    square = @board.board[start_position.first][start_position.last]
    return false unless square.is_a?(Piece) && square.color == @current_player.color

    move.all? { |coord| coord.between?(0, 7) }
  end

  def legal_move?(move)
    start_position = move.first(2)
    end_position = move.last(2)

    piece = @board.board[start_position.first][start_position.last]
    legal_moves = piece.legal_moves(@board.board, @current_player, start_position)

    legal_moves.include?(end_position)
  end

  def move_piece(move)
    start_position = move.first(2)
    end_position = move.last(2)

    piece = @board.board[start_position.first][start_position.last]

    @board.board[end_position.first][end_position.last] = piece
    @board.board[start_position.first][start_position.last] = EmptySquare.new

    if [end_position] == piece.get_en_passant(@board.board, @current_player, start_position)
      if @current_player.color == :black
        @board.board[end_position.first][end_position.last - 1] = EmptySquare.new
      else
        @board.board[end_position.first][end_position.last + 1] = EmptySquare.new
      end
    end

    piece.has_moved = true if piece.is_a?(Pawn)

    if piece.is_a?(Pawn) && (end_position.last - start_position.last == 2 || start_position.last - end_position.last == 2) # if pawn makes en passant move
      x = end_position.first
      y = end_position.last

      square_left = @board.board[x - 1][y] unless @board.board[x - 1].nil?
      if square_left.is_a?(Pawn) && square_left.color != @current_player.color
        square_left.en_passant_allowed = true
      end

      square_right = @board.board[x + 1][y] unless @board.board[x + 1].nil?
      if square_right.is_a?(Pawn) && square_right.color != @current_player.color
        square_right.en_passant_allowed = true
      end
    end
  end

  def switch_player
    @current_player.color = (@current_player.color == :white) ? :black : :white
  end

  def check?
    # detect if player's king is in check (probably at start of turn)
      # if true, restrict player's moves to escape check
      # if false, allow any legal moves
  end

  def checkmate?
    # detect checkmate by analyzing all possible moves
    # and determing if the king has no legal moves left
  end

  def stalemate?
    # detect stalemate
  end

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
end
