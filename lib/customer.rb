require_relative './menu.rb'
$client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']

class Customer
  def initialize(number)
   @number = number
   @selected = []
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

  def order(order_time = Time.now)
    text(@number, get_prerp_time(order_time))
  end

  def get_prerp_time(order_time)
    longest = @selected.max_by {|dish| dish.prep_time}.prep_time
    (order_time + longest * 60).strftime('%H:%M')
  end

  def text(number, time)
    $client.messages.create(
      from: '+18146374780',
      to: @number,
      body: "Thank you! Your order was placed and will be delivered before #{time}"
    )
  end
end
