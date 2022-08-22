class Dish
  def initialize(name, price, prep_time)
    @name, @price, @prep_time = name, price, prep_time
  end

  attr_accessor :name, :price, :prep_time
end