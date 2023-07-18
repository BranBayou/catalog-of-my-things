require 'json'
require 'date'
require_relative 'book'
require_relative 'label'

BOOKS_FILE = 'books.json'.freeze
LABELS_FILE = 'labels.json'.freeze

File.write(BOOKS_FILE, '[]') unless File.exist?(BOOKS_FILE)
File.write(LABELS_FILE, '[]') unless File.exist?(LABELS_FILE)

def display_options
  puts 'Options:'
  puts '1. List all books'
  puts '2. List all labels'
  puts '3. Add a book'
  puts '4. Quit'
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
  File.write(BOOKS_FILE, books.map(&:to_json).to_json)
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
  File.write(LABELS_FILE, labels.map(&:to_json).to_json)
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

books = load_books || []
labels = load_labels || []

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
    add_book(books)
  when 4
    save_books(books)
    save_labels(labels)
    puts 'Quitting the app...'
    break
  else
    puts 'Invalid option. Please try again.'
  end

  puts "\n"
end
