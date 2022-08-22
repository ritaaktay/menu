require 'customer'
require 'dish'
require 'dotenv/load'

RSpec.describe "Customer Integration" do
  it "orders selected dishes and sends text including prep time" do
    io = double :io
    dish_1 = Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    customer = Customer.new(ENV["PHONE_NUM"])
    customer.select(dish_1, dish_2)
    time = Time.new(2022,8,22,18,0,0, "+00:00")
    expect(customer.order(time).body).to eq "Sent from your Twilio trial account - Thank you! Your order was placed and will be delivered before 18:20"
  end
end