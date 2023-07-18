require_relative 'item'

class Label
  attr_accessor :name, :items

  def initialize(name)
    @name = name
    @items = []
  end

  def add_item(item)
    item.label = self
    items << item
  end

  def to_json(*_args)
    {
      name: name,
      items: items.map(&:to_json)
    }.to_json
  end

  def self.from_json(json)
    data = JSON.parse(json)
    label = new(data['name'])
    data['items'].each do |item_json|
      item = Item.from_json(item_json)
      item.label = label
      label.items << item
    end
    label
  end
end
