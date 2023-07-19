require 'json'

class Item
  attr_accessor :name, :published_date, :archived

  def initialize(name, published_date)
    @name = name
    @published_date = published_date
    @archived = false
  end

  def can_be_archived?
    today = Date.today
    published_date < (today - (10 * 365))
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      puts "#{name} has been archived."
    else
      puts "#{name} cannot be archived."
    end
  end

  def to_json(*_args)
    {
      name: name,
      published_date: published_date.to_s,
      archived: archived
    }.to_json
  end

  def self.from_json(json)
    data = JSON.parse(json)
    new(data['name'], Date.parse(data['published_date'])).tap do |item|
      item.archived = data['archived']
    end
  end
end
