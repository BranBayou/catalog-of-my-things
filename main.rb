require_relative 'item'
def display_options
  puts 'Options:'
  puts '1. Create a new item'
  puts '2. Archive an item'
  puts '3. Quit'
end

def create_item
  puts 'Enter item name:'
  name = gets.chomp
  puts 'Enter published date (YYYY-MM-DD):'
  published_date = gets.chomp
  Item.new(name, Date.parse(published_date))
  puts "#{name} has been created."
end

def archive_item
  puts 'Enter item name:'
  name = gets.chomp
  item = Item.new(name, Date.today)
  item.move_to_archive
end
loop do
  display_options
  option = gets.chomp.to_i
  case option
  when 1
    create_item
  when 2
    archive_item
  when 3
    break
  else
    puts 'Invalid option. Please try again.'
  end
end
