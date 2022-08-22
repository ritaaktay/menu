require 'menu'
require 'dish'

RSpec.describe Menu do
  it "shows a list of dishes with prices" do
    io = double(:io)
    menu = Menu.new(io)
    dish_1 =Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    menu.add(dish_1, dish_2)
    expect(io).to receive(:puts).with("Pecan Pie £23.00")
    expect(io).to receive(:puts).with("Banana Bread £16.50")
    menu.display(menu.dishes) 
  end

  it "selects dishes" do
    menu = Menu.new(double(:io))
    dish_1 =Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    dish_3 = Dish.new("Pavlova", 8.5, 15)
    menu.add(dish_1, dish_2, dish_3)
    menu.select(dish_2, dish_3)
    expect(menu.selected).to eq [dish_2, dish_3]
  end

  it "shows itemised receipt of selected items" do
    io = double(:io)
    menu = Menu.new(io)
    dish_1 =Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    dish_3 = Dish.new("Pavlova", 8.5, 15)
    menu.add(dish_1, dish_2, dish_3)
    menu.select(dish_1, dish_2)
    expect(io).to receive(:puts).with("Pecan Pie £23.00")
    expect(io).to receive(:puts).with("Banana Bread £16.50")
    expect(io).to receive(:puts).with("TOTAL £39.50")
    menu.receipt
  end

  it "orders selected items after customer verification" do
    io = double(:io)
    menu = Menu.new(io)
    dish_1 =Dish.new("Pecan Pie", 23, 20)
    dish_2 = Dish.new("Banana Bread", 16.5, 20)
    dish_3 = Dish.new("Pavlova", 8.5, 15)
    menu.add(dish_1, dish_2, dish_3)
    menu.select(dish_1, dish_2)
    expect(io).to receive(:puts).with("Please type 'Y' if you are happy to proceed with the below order").ordered
    expect(io).to receive(:puts).with("Pecan Pie £23.00").ordered
    expect(io).to receive(:puts).with("Banana Bread £16.50").ordered
    expect(io).to receive(:puts).with("TOTAL £39.50").ordered
    expect(io).to receive(:gets).and_return("Y").ordered
    expect(io).to receive(:puts).with "Thank you! Your order was placed and will be delivered before 13:50"
    menu.order(Time.new(2022,8,22,13,30,0,"+00:00"))
  end
end