require 'json'
require 'date'
require_relative 'book'
require_relative 'label'
require_relative 'game'
require_relative 'item'
require_relative 'music'
require_relative 'genre'

class App
  attr_reader :books, :labels, :games, :musics

  def initialize
    @books = load_books || []
    @labels = load_labels || []
    @games = load_games || []
    @musics = load_music_album || []
    @genres = []
  end

  BOOKS_FILE = './json/books.json'.freeze
  LABELS_FILE = './json/labels.json'.freeze
  GAMES_FILE = './json/games.json'.freeze
  MUSIC_FILE = './json/music.json'.freeze

  def load_music_album
    return [] unless File.exist?(MUSIC_FILE)

    File.open(MUSIC_FILE, 'r') do |file|
      json_data = file.read
      return [] if json_data.empty?

      begin
        # Ensure json_data is passed as a string to from_json
        JSON.parse(json_data).map { |music_json| MusicAlbum.from_json(music_json.to_json) }
      rescue JSON::ParserError
        puts 'Error: Unable to parse JSON data in music.json. Creating a new empty list of music albums.'
        []
      end
    end
  end

  def list_music_album(musics)
    puts 'Music albums:'
    if musics.empty?
      puts 'No musics found.'
    else
      musics.each do |music|
        puts "Title: #{music.name}"
        puts "Published date: #{music.published_date}"
        puts "Spotify: #{music.on_spotify}"
        puts '---'
      end
    end
  end

  def add_music_album(musics)
    puts 'Enter the title of the music album: '
    title = gets.chomp
    puts 'Enter the published date of the music album (YYYY-MM-DD): '
    published_date = gets.chomp
    puts 'Is the music album available on Spotify? (true/false): '
    on_spotify = gets.chomp.downcase == 'true'

    music_album = MusicAlbum.new(Date.parse(published_date), false, on_spotify)
    musics << music_album

    genre_name = gets.chomp
    genre = @genres.find { |g| g.name == genre_name } || add_genre(genre_name)
    genre.add_item(music_album) # The error might be here if genre is nil

    puts "Music album '#{title}' added."
  end

  def add_genre(name)
    genre = Genre.new(name)
    @genres << genre
    genre
  end

  def list_genre
    puts 'Genres:'
    if @genres.empty?
      puts 'No genres found.'
    else
      @genres.each do |genre|
        puts "Genre Name: #{genre.name}"
        puts 'Items:'
        if genre.item.empty?
          puts 'No items found.'
        else
          genre.item.each do |item|
            puts "- #{item.name} (Published Date: #{item.published_date})"
          end
        end
        puts '---'
      end
    end
  end

  def save_musics(musics)
    File.write(MUSIC_FILE, JSON.pretty_generate(musics.map(&:to_json)))
  end

  def add_book(books)
    print 'Enter the title of the book: '
    title = gets.chomp
    print 'Enter the author of the book: '
    author = gets.chomp
    print 'Enter the published date of the book (YYYY-MM-DD): '
    published_date = gets.chomp
    print 'Enter the cover state of the book: '
    cover_state = gets.chomp

    book = Book.new(title, Date.parse(published_date), author, cover_state)
    books << book
    puts "Book '#{book.name}' added."
  end

  def load_books
    return [] unless File.exist?(BOOKS_FILE)

    File.open(BOOKS_FILE, 'r') do |file|
      json_data = file.read
      return [] if json_data.empty?

      begin
        JSON.parse(json_data).map { |book_json| Book.from_json(book_json) }
      rescue JSON::ParserError
        puts 'Error: Unable to parse JSON data in books.json. Creating a new empty list of books.'
        []
      end
    end
  end

  def list_books(books)
    puts 'Books:'
    if books.empty?
      puts 'No books found.'
    else
      books.each do |book|
        puts "Title: #{book.name}"
        puts "Author: #{book.author}"
        puts "Published Date: #{book.published_date}"
        puts "Cover State: #{book.cover_state}"
        puts "Archived: #{book.archived}"
        puts '---'
      end
    end
  end

  def save_books(books)
    File.write(BOOKS_FILE, JSON.pretty_generate(books.map(&:to_json)))
  end

  def load_labels
    return [] unless File.exist?(LABELS_FILE)

    File.open(LABELS_FILE, 'r') do |file|
      json_data = file.read
      return [] if json_data.empty?

      begin
        JSON.parse(json_data).map { |label_json| Label.from_json(label_json) }
      rescue JSON::ParserError
        puts 'Error: Unable to parse JSON data in labels.json. Creating a new empty list of labels.'
        []
      end
    end
  end

  def list_labels(labels)
    puts 'Labels:'
    if labels.empty?
      puts 'No labels found.'
    else
      labels.each do |label|
        puts "Label: #{label.name}"
        puts 'Items:'
        if label.items.empty?
          puts 'No items found.'
        else
          label.items.each do |item|
            puts "- #{item.name}"
          end
        end
        puts '---'
      end
    end
  end

  def save_labels(labels)
    File.write(LABELS_FILE, JSON.pretty_generate(labels.map(&:to_json)))
  end

  def add_game(games)
    print 'Enter the title of the game: '
    title = gets.chomp
    print 'Enter the published date of the game (YYYY-MM-DD): '
    published_date = gets.chomp
    print 'Enter the last played date of the game (YYYY-MM-DD): '
    last_played_date = gets.chomp

    game = Game.new(title, Date.parse(published_date), last_played_date)
    games << game
    puts "Game '#{game.name}' added."
  end

  def load_games
    return [] unless File.exist?(GAMES_FILE)

    File.open(GAMES_FILE, 'r') do |file|
      json_data = file.read
      return [] if json_data.empty?

      begin
        JSON.parse(json_data).map { |game_json| Game.from_json(game_json) }
      rescue JSON::ParserError
        puts 'Error: Unable to parse JSON data in games.json. Creating a new empty list of games.'
        []
      end
    end
  end

  def list_games(games)
    puts 'Games:'
    if games.empty?
      puts 'No games found.'
    else
      games.each do |game|
        puts "Title: #{game.name}"
        puts "Published Date: #{game.published_date}"
        puts "Last Played Date: #{game.last_played_at}"
        puts "Archived: #{game.archived}"
        puts '---'
      end
    end
  end

  def save_games(games)
    File.write(GAMES_FILE, JSON.pretty_generate(games.map(&:to_json)))
  end
end
