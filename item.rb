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
end
