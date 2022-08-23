require_relative './dish'
require 'twilio-ruby'
require 'dotenv/load'

class Menu
  def initialize(io = Kernel)
    @io = io
    @dishes = []
  end

  def add(*dishes)
    dishes.each do  |dish|
      @dishes << dish
    end
  end

  def display(dishes = @dishes)
    dishes.each do |dish|
      @io.puts "#{dish.name} £%.2f" % dish.price
    end
  end

  def receipt(dishes)
    display(dishes)
    total = dishes.sum {|dish| dish.price}
    @io.puts "TOTAL £%.2f" % total
  end

  def get_prep_time(dishes, order_time)
    longest = dishes.max_by {|dish| dish.prep_time}.prep_time
    (order_time + longest * 60).strftime('%H:%M')
  end
end


