require 'json'
require 'date'
require_relative 'item'
require_relative 'book'
require_relative 'label'

class App

  BOOKS_FILE = './json/books.json'.freeze
  LABELS_FILE = './json/labels.json'.freeze

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

  def archive_item
    puts 'Enter item name:'
    name = gets.chomp
    item = Item.new(name, Date.today)
    item.move_to_archive
  end

  def list_all_books
    puts 'Empty shulf!'
  end

  def create_item
    puts 'Enter item name:'
    name = gets.chomp
    puts 'Enter published date (YYYY-MM-DD):'
    published_date = gets.chomp
    Item.new(name, Date.parse(published_date))
    puts "#{name} has been created."
  end
end