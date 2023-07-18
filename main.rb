require_relative 'item'
require_relative 'app'

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
    list_all_books
  when 2
    list_all_music_albums
  when 3
    list_all_games
  when 4
    list_all_geners
  when 5
    list_all_labels
  when 6
    list_all_authors
  when 7
    list_all_sources
  when 8
    add_book
  when 9
    add_music_album
  when 10
    add_game
  when 11
    break
  else
    puts 'Invalid option. Please try again.'
  end
end
