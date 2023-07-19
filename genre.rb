require_relative 'item'

class Genre
  attr_reader :id
  attr_accessor :name, :item

  def initialize(name)
    @id = Random.rand(1000..9999)
    @name = name
    @item = [] # Initialize @item as an empty array
  end

  def add_item(item)
    @item << item # Fix the method to use @item instead of @items
    item.genre = self
  end
end
