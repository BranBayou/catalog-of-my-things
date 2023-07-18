require 'json'
require_relative 'item'

class Game < Item
  attr_accessor :last_played_at

  def initialize(name, published_date, last_played_at)
    super(name, published_date)
    @last_played_at = last_played_at
  end

  def can_be_archived?
    parent_can_be_archived = super
    return false unless parent_can_be_archived

    today = Date.today
    two_years_ago = today - (2 * 365) # 2 years in days

    Date.parse(last_played_at) < two_years_ago
  end

  def to_json(*_args)
    {
      name: name,
      published_date: published_date.to_s,
      last_played_at: last_played_at,
      archived: archived
    }.to_json
  end

  def self.from_json(json)
    data = JSON.parse(json)
    new(data['name'], Date.parse(data['published_date']), data['last_played_at']).tap do |game|
      game.archived = data['archived']
    end
  end
end
