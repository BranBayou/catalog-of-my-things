require 'json'
require 'date'
require_relative 'book'
require_relative 'label'
require_relative 'game'
require_relative 'item'

BOOKS_FILE = 'books.json'.freeze
LABELS_FILE = 'labels.json'.freeze
GAMES_FILE = 'games.json'.freeze

def display_options
  puts 'Options:'
  puts '1. List all books'
  puts '2. List all labels'
  puts '3. List all games'
  puts '4. Add a book'
  puts '5. Add a game'
  puts '6. Quit'
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

def save_labels(labels)
  File.write(LABELS_FILE, JSON.pretty_generate(labels.map(&:to_json)))
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

def save_games(games)
  File.write(GAMES_FILE, JSON.pretty_generate(games.map(&:to_json)))
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

books = load_books || []
labels = load_labels || []
games = load_games || []

loop do
  display_options
  print 'Choose an option: '
  option = gets.chomp.to_i

  case option
  when 1
    list_books(books)
  when 2
    list_labels(labels)
  when 3
    list_games(games)
  when 4
    add_book(books)
  when 5
    add_game(games)
  when 6
    save_books(books)
    save_labels(labels)
    save_games(games)
    puts 'Quitting the app...'
    break
  else
    puts 'Invalid option. Please try again.'
  end

  puts "\n"
end
