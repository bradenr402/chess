require 'yaml'

def save_game(current_game)
  Dir.mkdir('saved_games') unless Dir.exist?('saved_games')

  if File.exist?("saved_games/#{@file_name}") && !File.directory?("saved_games/#{@file_name}")
    File.open("saved_games/#{@file_name}", 'w') { |file| file.write(YAML.dump(current_game)) }
    puts "  Game saved to:  #{@file_name}"
  else
    id = 1
    saved_successfully = false
    until saved_successfully
      if File.exist?("saved_games/save_game#{id}.yml")
        id += 1
      else
        File.open("saved_games/save_game#{id}.yml", 'w') { |file| file.write(YAML.dump(current_game)) }
        saved_successfully = true
      end
    end
    puts "  Game saved to:  #{"save_game#{id}.yml".green}"
  end


end

def load_game
  if Dir.empty?('saved_games/')
    puts "  No saved games found.\n\n"
    sleep(0.75)
    return new_game
  end

  saved_files = Dir.entries('saved_games/')
  saved_files.sort!.shift(2) # removes . and .. from list

  files_hash = {}
  saved_files.each do |file|
    files_hash["#{file.split('')[9]}"] = file
  end

  puts "\n  Which game would you like to load? (Press '#{'N'.blue}' to start a new game instead)"
  files_hash.each { |key, value| puts "    #{"[#{key}]".red} #{value.blue}" }

  case file_choice = get_char
  when 'N', 'n'
    new_game
  when '1'..files_hash.size.to_s
    @file_name = "save_game#{file_choice}.yml"
    puts "  Opening #{@file_name}...\n\n"
    sleep(0.75)
    File.open("saved_games/#{@file_name}", 'r') { |file| YAML.load_file(file, permitted_classes: [Game, Board, Player, EmptySquare, Pawn, Knight, Rook, Bishop, King, Queen, Symbol], aliases: true) }
  else
    load_game
  end
end

def new_game
  puts "  Starting new game..."
  sleep(0.75)
  game = Game.new
  introduction
  return game
end
