require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify, :genre

  def initialize(published_date, archived, on_spotify)
    super(published_date, archived)
    @on_spotify = on_spotify
  end

  def can_be_archived
    super && @on_spotify
  end

  def self.from_json(json)
    data = JSON.parse(json)
    # Ensure that the 'published_date' in the JSON data is in the correct format (YYYY-MM-DD)
    published_date = begin
      Date.parse(data['published_date'])
    rescue StandardError
      nil
    end
    return nil if published_date.nil?

    music_album = new(published_date, data['archived'], data['on_spotify'])

    genre_name = data['genre_name']
    music_album.genre = Genre.new(genre_name)

    music_album
  end
end
