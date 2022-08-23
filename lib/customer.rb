require_relative './menu.rb'
require_relative './texter.rb'

class Customer
  def initialize(number)
   @number = number
   @selected = []
  end

  attr_reader :selected

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

  def order(order_time = Time.now, texter = Texter.new)
    time = Menu.new.get_prep_time(@selected, order_time)
    message = "Thank you! Your order was placed and will be delivered before #{time}"
    texter.send_sms(body: message, to: @number)
  end
end
