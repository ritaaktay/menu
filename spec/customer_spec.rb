require 'customer'
require 'dotenv/load'

describe Customer do 
  it "initializes customer" do
    expect(Customer.new(ENV["PHONE_NUM"])).to be
  end

  it "selects dishes" do
    dish_1 = double :dish_1
    dish_2 = double :dish_2
    customer = Customer.new(ENV["PHONE_NUM"])
    customer.select(dish_1, dish_2)
    expect(customer.selected).to eq [dish_1, dish_2]
  end

  it "unselects dishes" do
    dish_1 = double :dish_1
    dish_2 = double :dish_2
    customer = Customer.new(ENV["PHONE_NUM"])
    customer.select(dish_1, dish_2)
    customer.unselect(dish_1)
    expect(customer.selected).to eq [dish_2]
  end

  it "orders selected items and sends confirmation text" do
    customer = Customer.new(ENV["PHONE_NUM"])
    dish_1 = double(:dish_1, name: "Hamburger", prep_time: 40)
    dish_2 = double(:dish_2, name: "Carbonara", prep_time: 35)
    customer.select(dish_1, dish_2)
    time = Time.new(2022,8,22,18,0,0, "+00:00")
    texter = double(:texter)
    expect(texter).to receive(:send_sms).with(hash_including(:body, :to))
    customer.order(time, texter)
  end
end


