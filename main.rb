require_relative 'app'

app = App.new

def display_options
  puts ''
  puts 'Welcom to catalog of my things!'
  puts ''
  puts '1. List all books'
  puts '2. List all music albums'
  puts '3. List all games'
  puts '4. List all genres'
  puts '5. List all labels'
  puts '6. List all authors'
  puts '7. List all sources'
  puts '8. Add a book'
  puts '9. Add a music album'
  puts '10. Add a game'
  puts '11. Quit'
end

loop do
  display_options
  option = gets.chomp.to_i
  case option
  when 1
    app.list_books
  when 2
    app.list_music_album
  when 3
    app.list_games
  when 4
    app.list_genre
  when 5
    app.list_labels
  when 6
    app.list_authors
  when 7
    list_all_sources
  when 8
    app.add_book
  when 9
    app.add_music_album
  when 10
    app.add_game
  when 11
    puts 'Thank you for using this app...'
    break
  else
    puts 'Invalid option. Please try again.'
  end
end
