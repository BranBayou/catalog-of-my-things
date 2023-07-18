require_relative 'item'

class Book < Item
  attr_accessor :author, :cover_state

  def initialize(name, published_date, author, cover_state)
    super(name, published_date)
    @author = author
    @cover_state = cover_state
  end

  def can_be_archived?
    super || cover_state == 'bad'
  end

  def to_json(*_args)
    {
      name: name,
      published_date: published_date.to_s,
      author: author,
      cover_state: cover_state,
      archived: archived
    }.to_json
  end

  def self.from_json(json)
    data = JSON.parse(json)
    new(
      data['name'],
      Date.parse(data['published_date']),
      data['author'],
      data['cover_state']
    ).tap do |book|
      book.archived = data['archived']
    end
  end
end
