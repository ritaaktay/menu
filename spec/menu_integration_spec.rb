require 'menu'
require 'dish'

RSpec.describe Menu do
  it "displays dishes with prices" do
    io = double(:io)
    menu = Menu.new(io)
    dish_1 =Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    menu.add(dish_1, dish_2)
    expect(io).to receive(:puts).with("Pecan Pie £23.00")
    expect(io).to receive(:puts).with("Banana Bread £16.50")
    menu.display 
  end

  it "shows itemised receipt of with total" do
    io = double(:io)
    menu = Menu.new(io)
    dish_1 =Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    expect(io).to receive(:puts).with("Pecan Pie £23.00")
    expect(io).to receive(:puts).with("Banana Bread £16.50")
    expect(io).to receive(:puts).with("TOTAL £39.50")
    menu.receipt([dish_1, dish_2])
  end

  it "calculates prep time for array of dishes" do
    io = double(:io)
    menu = Menu.new(io)
    dish_1 =Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    time = Time.new(2022,8,23,16,0,0,"+00:00")
    expect(menu.get_prep_time([dish_1, dish_2],time)).to eq "16:20"
  end
end