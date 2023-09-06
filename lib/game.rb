class Game
  def initialize
    @board = Board.new
    @current_player = Player.new(:white)
  end

  def play_game
    introduction
    blank_line = true
    loop do
      if checkmate?
        puts "Checkmate, #{@current_player}! #{opponent} wins!"
        break
      end

      puts "\n" if blank_line
      puts check? ? check_message : "\n\n"
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
        if move == 'castle left'
          castle_left
        elsif move == 'castle right'
          castle_right
        else
          move_piece(move)
        end
      else
        system('clear')
        @board.display
        puts '    Invalid move. Try again.'
        blank_line = false
        next
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
    return true if move == 'castle left' || move == 'castle right'
    return false unless move.size == 4
    return false if move.any? { |coord| coord.nil? }

    start_position = move.first(2)
    square = @board.board[start_position.first][start_position.last]
    return false unless square.is_a?(Piece) && square.color == @current_player.color

    move.all? { |coord| coord.between?(0, 7) }
  end

  def legal_move?(move)
    return castle_allowed?(move) if move.include?('castle')

    return false unless escapes_check?(move)

    start_position = move.first(2)
    end_position = move.last(2)

    piece = @board.board[start_position.first][start_position.last]
    legal_moves = piece.legal_moves(@board.board, @current_player, start_position)

    legal_moves.include?(end_position)
  end

  def move_piece(move, board = @board.board)
    start_position = move.first(2)
    end_position = move.last(2)

    piece = board[start_position.first][start_position.last] # gets piece
    board[end_position.first][end_position.last] = piece # moves piece to new square
    board[start_position.first][start_position.last] = EmptySquare.new # removes piece from previous square

    if piece.is_a?(Pawn)
      piece.has_moved = true
      if attack_is_en_passant?(piece, start_position, end_position)
        if @current_player.color == :black
          board[end_position.first][end_position.last - 1] = EmptySquare.new
        else
          board[end_position.first][end_position.last + 1] = EmptySquare.new
        end
      end
    end

    disallow_all_en_passant
    allow_en_passant(piece, start_position, end_position)
    update_castle_allowed(piece, start_position, end_position)

    board
  end

  def switch_player
    @current_player.color = (@current_player.color == :white) ? :black : :white
  end

  def opponent
    Player.new(@current_player.opposite_color)
  end

  def attack_is_en_passant?(piece, start_position, end_position)
    [end_position] == piece.get_en_passant(@board.board, @current_player, start_position)
  end

  def allow_en_passant(piece, start_position, end_position)
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

  def disallow_all_en_passant
    @board.board.each do |row|
      row.each do |piece|
        if piece.is_a?(Pawn)
          piece.en_passant_allowed = false
        end
      end
    end
  end

  def update_castle_allowed(piece, start_position, end_position)
    if piece.is_a?(King)
      @current_player.castle_left_allowed = false
      @current_player.castle_right_allowed = false
    end

    if piece.is_a?(Rook)
      @current_player.castle_left_allowed = false if start_position == [0, 0] || start_position == [7, 0]
      @current_player.castle_right_allowed = false if start_position == [0, 7] || start_position == [7, 7]
    end
  end

  def castle_allowed?(move)
    return false if check?

    if move == 'castle left'
      if @current_player.color == :black
        return @current_player.castle_left_allowed &&
               @board.board[1][0].is_a?(EmptySquare) &&
               @board.board[2][0].is_a?(EmptySquare) &&
               @board.board[3][0].is_a?(EmptySquare)
      else
        return @current_player.castle_left_allowed &&
               @board.board[1][7].is_a?(EmptySquare) &&
               @board.board[2][7].is_a?(EmptySquare) &&
               @board.board[3][7].is_a?(EmptySquare)
      end
    elsif move == 'castle right'
      if @current_player.color == :black
        return @current_player.castle_right_allowed &&
               @board.board[5][0].is_a?(EmptySquare) &&
               @board.board[6][0].is_a?(EmptySquare)
      else
        return @current_player.castle_right_allowed &&
               @board.board[5][7].is_a?(EmptySquare) &&
               @board.board[6][7].is_a?(EmptySquare)
      end
    end
  end

  def castle_left
    if @current_player.color == :black
      rook = @board.board[0][0]
      king = @board.board[4][0]

      @board.board[3][0] = rook
      @board.board[0][0] = EmptySquare.new

      @board.board[2][0] = king
      @board.board[4][0] = EmptySquare.new
    else
      rook = @board.board[0][7]
      king = @board.board[4][7]

      @board.board[3][7] = rook
      @board.board[0][7] = EmptySquare.new

      @board.board[2][7] = king
      @board.board[4][7] = EmptySquare.new
    end
  end

  def castle_right
    if @current_player.color == :black
      rook = @board.board[7][0]
      king = @board.board[4][0]

      @board.board[5][0] = rook
      @board.board[7][0] = EmptySquare.new

      @board.board[6][0] = king
      @board.board[4][0] = EmptySquare.new
    else
      rook = @board.board[7][7]
      king = @board.board[4][7]

      @board.board[5][7] = rook
      @board.board[7][7] = EmptySquare.new

      @board.board[6][7] = king
      @board.board[4][7] = EmptySquare.new
    end
  end

  def check?(board = @board.board)
    king_position = []
    board.each_with_index do |row, i|
      row.each_with_index do |square, j|
        king_position = [i, j] if square.is_a?(King) && square.color == @current_player.color
      end
    end

    board.each_with_index do |row, i|
      row.each_with_index do |square, j|
        square_position = [i, j]
        if square.color == @current_player.opposite_color
          legal_moves = square.legal_moves(board, opponent, square_position)
          return true if legal_moves.include?(king_position)
        end
      end
    end
    false
  end

  def escapes_check?(move)
    new_board = Array.new(8) { Array.new(8, EmptySquare.new) }

    @board.board.each_with_index do |row, i|
      row.each_with_index do |square, j|
        square_class = square.class
        if square.is_a?(Piece)
          new_board[i][j] = square_class.new(square.color)
        end
      end
    end

    new_board = move_piece(move, new_board)

    !check?(new_board)
  end

  def checkmate?(board = @board.board)
    return false unless check?

    board.each_with_index do |row, i|
      row.each_with_index do |square, j|
        square_position = [i, j]
        if square.color == @current_player.color
          legal_moves = square.legal_moves(board, @current_player, square_position)
          legal_moves.map! { |move| square_position + move }
          return false if legal_moves.any? { |move| escapes_check?(move) }
        end
      end
    end
    true
  end

  def stalemate?
    # detect stalemate
  end

  def check_message
    "\n    #{@current_player}, you are in check!"
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
