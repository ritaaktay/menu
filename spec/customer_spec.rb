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

  it "orders" do
    customer = Customer.new(ENV["PHONE_NUM"])
    dish_1 = double(:dish_1, name: "Hamburger", price: 20, prep_time: 40)
    dish_2 = double(:dish_2, name: "Carbonara", price: 19, prep_time: 35)
    customer.select(dish_1, dish_2)
    time = Time.new(2022,8,22,18,0,0, "+00:00")
    texter = double(:texter)
    allow(texter).to receive(:send_sms).with(hash_including(:body, :to))
    .and_return({body: "Sent from your Twilio trial account - Thank you! Your order was placed and will be delivered before 18:40"},
                 to: ENV["PHONE_NUM"])
    expect(customer.order(time, texter)[:body]).to eq "Sent from your Twilio trial account - Thank you! Your order was placed and will be delivered before 18:40"
    expect(customer.order(time, texter)[:to]).to eq ENV["PHONE_NUM"]
  end
end


