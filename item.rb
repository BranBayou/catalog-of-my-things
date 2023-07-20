require_relative 'label'
require 'date'

class Item
  attr_accessor :genre, :author, :label, :publish_date
  attr_reader :id, :archived

  def initialize(publish_date, archived, id = Random.rand(1000...9999))
    @id = id
    @publish_date = publish_date
    @archived = archived
    @label = nil
    @genre = nil
    @author = nil
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    Date.today.year - @publish_date.year > 10
  end
end
