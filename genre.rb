require_relative 'item'

class Genre
  attr_reader :id
  attr_accessor :name, :item

  def initialize(name)
    @id = Random.rand(1000..9999)
    @name = name
    @item = []
  end

  def add_item
    @item << item
    item.genre = self
  end
end
