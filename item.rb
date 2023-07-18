require 'date'

class Item
  attr_accessor :name, :published_date, :archived
  attr_reader :id

  def initialize(name, published_date)
    @id = rand(1000..9999)
    @published_date = published_date
    @archived = false
    @label = nil
    @genre = nil
    @author = nil
  end

  def move_to_archive
    if can_be_archived?
      @archived = true
      puts "#{name} has been archived."
    else
      puts "#{name} cannot be archived."
    end
  end

  private

  def can_be_archived?
    today = Date.today
    published_date < (today - (10 * 365))
  end
end
