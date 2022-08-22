require_relative './dish'

class Menu
  def initialize(io)
    @io, @dishes, @selected = io, [], []
  end

  attr_reader :dishes, :selected

  def add(*dishes)
    dishes.each do  |dish|
      @dishes << dish
    end
  end

  def display(dishes)
    dishes.each do |dish|
      @io.puts "#{dish.name} £%.2f" % dish.price
    end
  end

  def select(*dishes)
    dishes.each do |dish|
      @selected << dish
    end
  end

  def unselect(*dishes)
    dishes.each do |dish|
      @selected.delete(dish)
    end
  end

  def receipt
    display(@selected)
    total = @selected.sum {|dish| dish.price}
    @io.puts "TOTAL £%.2f" % total
  end

  def order(time = Time.now)
    @io.puts "Please type 'Y' if you are happy to proceed with the below order"
    receipt
    return if !@io.gets.chomp =~ /Y/i 
    @io.puts "Thank you! Your order was placed and will be delivered before #{get_time(time)}"
    #texts customer
  end

  def get_time(time)
    longest = @selected.max_by {|dish| dish.prep_time}.prep_time
    (time + longest * 60).strftime('%H:%M')
  end

  def text
    #sends text to customer with delivery time
  end
end

# menu = Menu.new(Kernel)
# dish_1 =Dish.new("Pecan Pie", 23, 20)
# dish_2 = Dish.new("Banana Bread", 16.5, 20)
# dish_3 = Dish.new("Pavlova", 8.5, 15)
# menu.add(dish_1, dish_2, dish_3)
# menu.select(dish_1, dish_2)
# menu.order