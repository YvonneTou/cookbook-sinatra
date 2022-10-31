class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(name, description, rating = nil, prep_time = nil, complete = false)
    @name = name
    @rating = rating
    @description = description
    @prep_time = prep_time
    @complete = complete
  end

  def complete?
    @complete
  end

  def mark_as_complete
    @complete = true
  end
end
