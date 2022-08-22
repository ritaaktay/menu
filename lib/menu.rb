require_relative './dish'
require 'twilio-ruby'
require 'dotenv/load'

class Menu
  def initialize(io)
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
end


