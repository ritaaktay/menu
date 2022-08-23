require 'customer'
require 'dish'
require 'texter'

RSpec.describe "Customer Integration" do
  it "selects dishes" do
    dish_1 = Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    customer = Customer.new(ENV["PHONE_NUM"])
    customer.select(dish_1, dish_2)
    expect(customer.selected).to eq [dish_1, dish_2]
  end

  it "unselects dishes" do
    dish_1 = Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    customer = Customer.new(ENV["PHONE_NUM"])
    customer.select(dish_1, dish_2)
    customer.unselect(dish_1)
    expect(customer.selected).to eq [dish_2]
  end

  it "sends confirmation text for order of selected dishes" do
    dish_1 = Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    customer = Customer.new(ENV["PHONE_NUM"])
    customer.select(dish_1, dish_2)
    time = Time.new(2022,8,22,18,0,0, "+00:00")
    texter = double :texter
    expect(texter).to receive(:send_sms).with(hash_including(:body, :to))
    customer.order(time, texter)
  end
end