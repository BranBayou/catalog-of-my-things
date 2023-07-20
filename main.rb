require_relative 'app'

app = App.new

def display_options
  puts ''
  puts 'Welcome to catalog of my things!'
  puts ''
  puts '0. List all books'
  puts '1. List all music albums'
  puts '2. List all games'
  puts '3. List all genres'
  puts '4. List all labels'
  puts '5. List all authors'
  puts '6. Add a book'
  puts '7. Add a music album'
  puts '8. Add a game'
  puts '9. Quit'
end

loop do
  display_options
  option = gets.chomp.to_i
  case option
  when 0
    app.list_books
  when 1
    app.list_music_album
  when 2
    app.list_games
  when 3
    app.list_genres
  when 4
    app.list_labels
  when 5
    app.list_authors
  when 6
    app.add_book
  when 7
    app.add_music_album
  when 8
    app.add_game
  when 9
    puts 'Thank you for using this app...'
    break
  else
    puts 'Invalid option. Please try again.'
  end
end
