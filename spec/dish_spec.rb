require 'dish'

describe Dish do 
  it "initializes with name, price and prep time" do
    dish = Dish.new("Hamburger", 20, 40)
    expect(dish.name).to eq "Hamburger"
    expect(dish.price).to eq 20
    expect(dish.prep_time).to eq 40
  end
end