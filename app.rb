require_relative 'item'

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
