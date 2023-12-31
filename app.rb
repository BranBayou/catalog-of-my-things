require 'json'
require 'date'
require 'terminal-table'
require_relative 'item'
require_relative 'book'
require_relative 'game'
require_relative 'music'
require_relative 'genre'
require_relative 'label'
require_relative 'author'

class App
  FILE_PATH = "#{__dir__}/json/books.json".freeze
  GAMES_FILE = "#{__dir__}/json/games.json".freeze
  AUTHORS_FILE = "#{__dir__}/json/authors.json".freeze

  attr_accessor :games, :authors, :books

  def initialize(file: FILE_PATH)
    @file = file
    @books = load_books || []
    @games = load_games || []
    @authors = load_authors || []
  end

  def list_books
    if @books.empty?
      puts 'No books found!'
    else
      rows = @books.map do |book|
        [book.author, book.publisher, book.cover_state, book.publish_date]
      end

      table = Terminal::Table.new do |t|
        t.title = 'Book Info'
        t.headings = ['Author', 'Publisher', 'Cover State', 'Publish Date']
        t.rows = rows
      end

      puts table
    end
  end

  def list_labels
    labels = @books.map(&:label).uniq.compact

    if labels.empty?
      puts 'No labels found!'
    else
      rows = labels.map do |label|
        [label.color, label.name]
      end

      table = Terminal::Table.new do |t|
        t.title = 'Label Info'
        t.headings = %w[Color Name]
        t.rows = rows
      end

      puts table
    end
  end

  def add_book
    print 'Enter the book author: '
    author = gets.chomp

    print 'Enter the book publisher: '
    publisher = gets.chomp

    print 'Enter the publish date of the book (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)

    cover_state = ''
    until %w[g b].include?(cover_state)
      print 'Enter the cover state of the book: (G)ood or (B)ad?'
      cover_state = gets.chomp.downcase
    end

    print 'Enter label name (e.g: fiction, nonfiction, science): '
    name = gets.chomp.downcase

    print 'Enter the book label color: '
    color = gets.chomp.downcase

    book = Book.new(author, publish_date, publisher, cover_state == 'g' ? 'good' : 'bad')
    book.label = Label.new(1, name, color)
    @books << book

    puts '------------------------------------------', 'Book added successfully'
    save_books
  end

  def load_books
    return [] unless File.exist?(@file) && !File.empty?(@file)

    begin
      json_data = File.read(@file)
      books_data = JSON.parse(json_data, symbolize_names: true)
      return [] unless books_data.is_a?(Array)

      books_data.map do |book|
        label_data = book[:label]
        label = label_data.nil? ? nil : Label.new(1, label_data[:name], label_data[:color])
        Book.new(
          book[:author],
          book[:publish_date],
          book[:publisher],
          book[:cover_state],
          label: label
        )
      end
    rescue Errno::ENOENT, JSON::ParserError => e
      puts "An error occurred while trying to load books: #{e.message}"
      []
    end
  end

  def save_books
    books_json = @books.map do |book|
      label_data = book.label.is_a?(Label) ? { name: book.label.name, color: book.label.color } : book.label
      {
        author: book.author,
        publish_date: book.publish_date,
        publisher: book.publisher,
        cover_state: book.cover_state,
        label: label_data
      }
    end

    begin
      File.write(@file, books_json.to_json)
    rescue Errno::ENOENT => e
      puts "An error occurred while trying to save books: #{e.message}"
    end
  end

  def list_music_album
    file_path = './json/music.json'
    if File.exist?(file_path)
      file_content = File.read(file_path)
      music_data = JSON.parse(file_content)

      if music_data.empty?
        puts 'Empty album'
      else
        rows = music_data.map do |album|
          [album['publish_date'], album['archived'], album['on_spotify']]
        end

        table = Terminal::Table.new do |t|
          t.title = 'Music Album Info'
          t.headings = ['Published Date', 'Archived', 'On Spotify']
          t.rows = rows
        end

        puts table
      end
    else
      puts 'No album available'
    end
  end

  def list_genres
    file_path = './json/music.json'
    if File.exist?(file_path)
      file_content = File.read(file_path)
      music_data = JSON.parse(file_content)

      if music_data.empty?
        puts 'Empty genre'
      else
        genres = music_data.map { |album| album['genre'] }.uniq.compact

        rows = genres.map { |genre| [genre] }

        table = Terminal::Table.new do |t|
          t.title = 'Genres'
          t.rows = rows
        end

        puts table
      end
    else
      puts 'Empty genre'
    end
  end

  def filexists(music_data, file_path, music_hash)
    if File.empty?(file_path)
      File.write(file_path, JSON.generate(music_data))
      file_content = File.read(file_path)
      music_data_file = JSON.parse(file_content)
      music_data_file << music_hash
      File.write(file_path, JSON.generate(music_data))
    else
      file_content = File.read(file_path)
      music_data_file = JSON.parse(file_content)
      music_data_file << music_hash
      File.write(file_path, JSON.generate(music_data_file))
    end
  end

  def filenotexists(music_data, file_path, music_hash)
    File.write(file_path, JSON.generate(music_data))
    file_content = File.read(file_path)
    music_data = JSON.parse(file_content)
    music_data << music_hash
    puts music_data
    File.write(file_path, JSON.generate(music_data))
  end

  def inputmusic
    puts 'Enter Genre name'
    genre = gets.chomp
    puts 'Enter the publish date of the music album'
    publish_date = gets.chomp
    puts 'Is the music album archived? (true/false)'
    archived = gets.chomp
    puts 'Is the music album on spotify? (true/false)'
    on_spotify = gets.chomp
    [genre, publish_date, archived, on_spotify]
  end

  def add_music_album
    file_path = './json/music.json'
    genre, publish_date, archived, on_spotify = inputmusic
    music_hash = {
      genre: genre,
      publish_date: publish_date,
      archived: archived,
      on_spotify: on_spotify
    }
    music_data = []
    if File.exist?(file_path)
      filexists(music_data, file_path, music_hash)
    else
      filenotexists(music_data, file_path, music_hash)
    end
  end

  def add_game
    print 'Enter the publish date of the game (YYYY-MM-DD): '
    publish_date = Date.parse(gets.chomp)
    print 'Is the game multiplayer? [Y/N]: '
    multiplayer_input = gets.chomp
    multiplayer = %w[N n NO no No].include? multiplayer_input ? false : true
    last_played_at = Date.today
    game = Game.new(publish_date, multiplayer, last_played_at)
    author = choose_author
    author.add_item(game)
    save_authors
    @games << game
    puts 'Game created successfully.'
    save_games
  end

  def choose_author
    author = nil
    puts 'Do you want to add a new author or choose from available authors? [N/L]? '
    puts 'N: New author'
    puts 'L: List authors' unless authors.empty?
    input = gets.chomp.upcase
    if input == 'N'
      print 'Enter game author First Name: '
      first_name = gets.chomp
      print 'Enter game author Last Name: '
      last_name = gets.chomp
      author = Author.new(first_name, last_name)
      @authors.push(author)
    elsif input == 'L'
      puts 'Select an author from the list below:'
      @authors.each.with_index { |auth, index| puts "#{index}): #{auth.first_name} #{auth.last_name}" }
      author_index = gets.chomp.to_i
      author = @authors[author_index]
    end
    author
  end

  def list_games
    if @games.empty?
      puts 'Empty games!'
    else
      rows = @games.map do |game|
        [game.label&.title || game.publish_date, game.multiplayer ? 'Multiplayer' : 'Singleplayer', game.last_played_at]
      end

      table = Terminal::Table.new do |t|
        t.title = 'Game Info'
        t.headings = ['Publish Date', 'Player Mode', 'Last Played At']
        t.rows = rows
      end

      puts table
    end
  end

  def list_authors
    if authors.empty?
      puts 'Authors not found!'
    else
      rows = authors.map.with_index(1) do |author, index|
        [index, "#{author.first_name} #{author.last_name}", author.items.size]
      end

      table = Terminal::Table.new do |t|
        t.title = 'Author Info'
        t.headings = ['#', 'Author Name', 'Number of Items']
        t.rows = rows
      end

      puts table
    end
  end

  def save_games
    games_arr = []
    @games.each do |game|
      games_arr.push({
                       id: game.id,
                       publish_date: game.publish_date,
                       multiplayer: game.multiplayer,
                       last_played_at: game.last_played_at,
                       label: game.label,
                       author: game.author.nil? ? nil : "#{game.author.first_name} #{game.author.last_name}"
                     })
    end
    File.write(GAMES_FILE, JSON.pretty_generate(games_arr))
  end

  def save_authors
    authors_arr = []
    @authors.each do |author|
      authors_arr.push({
                         first_name: author.first_name,
                         last_name: author.last_name,
                         items: author.items.map do |item|
                                  {
                                    id: item.id,
                                    publish_date: item.publish_date,
                                    archived: item.archived
                                  }
                                end
                       })
    end
    File.write(AUTHORS_FILE, JSON.pretty_generate(authors_arr))
  end

  def load_games
    return [] if !File.exist?(GAMES_FILE) || File.empty?(GAMES_FILE)

    games_data = JSON.parse(File.read(GAMES_FILE), symbolize_names: true)
    return [] unless games_data.is_a?(Array)

    @games = []
    games_data.each do |game_data|
      publish_date = game_data[:publish_date]
      multiplayer = game_data[:multiplayer]
      last_played_at = game_data[:last_played_at]
      game = Game.new(publish_date, multiplayer, last_played_at)
      game.label = game_data[:label]
      author = Author.new(game_data[:author].split[0], game_data[:author].split[1])
      game.author = author
      game.genre = game_data[:genre]
      @games.push(game)
    end
    @games
  end

  def load_authors
    return [] if !File.exist?(AUTHORS_FILE) || File.empty?(AUTHORS_FILE)

    author_data = JSON.parse(File.read(AUTHORS_FILE), symbolize_names: true)
    return [] unless author_data.is_a?(Array)

    @authors = []
    author_data.each do |author_d|
      first_name = author_d[:first_name]
      last_name = author_d[:last_name]
      author = Author.new(first_name, last_name)
      author_d[:items].map do |item|
        author.add_item(Item.new(item[:publish_date], item[:archived], item[:id]))
      end
      @authors.push(author)
    end
    @authors
  end
end
