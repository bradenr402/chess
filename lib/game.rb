class Game
  def initialize
    @board = Board.new
    @white_player = Player.new(:white)
    @black_player = Player.new(:black)

    @current_player = @white_player
    @opponent = @black_player
  end

  def play_game
    introduction
    blank_line = true
    loop do
      break if game_over?

      puts "\n" if blank_line
      puts check? ? "\n    #{@current_player}, you are in check!" : "\n\n"
      move = prompt_move

      case move
      when 'help'
        system('clear')
        puts how_to_play
        print "    Press any key to continue: ".green
        get_char

        system('clear')
        @board.display
        next
      when 'save'
        # save game
        break
      when 'exit'
        exit
      end

      move = format_move(move) unless move.include?('castle')

      unless valid_move?(move) && legal_move?(move)
        system('clear')
        @board.display
        puts '    Invalid move. Try again.'
        blank_line = false
        next
      end

      if move == 'castle left'
        castle_left
        @current_player.castle_left_allowed = false
        @current_player.castle_right_allowed = false
      elsif move == 'castle right'
        castle_right
        @current_player.castle_left_allowed = false
        @current_player.castle_right_allowed = false
      else
        move_piece(move)

        start_position = move.first(2)
        end_position = move.last(2)
        piece = @board.board[end_position.first][end_position.last]

        if piece.is_a?(Pawn) && pawn_at_opposite_side?(piece, end_position)
          system('clear')
          @board.display
          @board.board[end_position.first][end_position.last] = promote(piece)
        end

        update_castle_allowed(piece, start_position, end_position)
        disallow_all_en_passant
        allow_en_passant(piece, start_position, end_position)
      end

      blank_line = true
      switch_players
      system('clear')
      @board.display
    end
  end

  def switch_players
    @current_player = (@current_player.color == :white) ? @black_player : @white_player
    @opponent = (@opponent.color == :white) ? @black_player : @white_player
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

    board
  end
end
