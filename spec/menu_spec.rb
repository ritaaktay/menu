require 'menu'

describe Menu do
  it "initializes" do
    expect(Menu.new(double :io)).to be
  end

  it "displays dishes" do
    io = double :io
    menu = Menu.new(io)
    dish_1 = double(:dish_1, name: "Hamburger", price: 20)
    dish_2 = double(:dish_2, name: "Carbonara", price: 19)
    menu.add(dish_1, dish_2)
    expect(io).to receive(:puts).with "Hamburger £20.00"
    expect(io).to receive(:puts).with "Carbonara £19.00"
    menu.display
  end

  it "prints itemised receipt" do
    io = double :io
    menu = Menu.new(io)
    dish_1 = double(:dish_1, name: "Hamburger", price: 20)
    dish_2 = double(:dish_2, name: "Carbonara", price: 19)
    menu.add(dish_1, dish_2)
    expect(io).to receive(:puts).with "Hamburger £20.00"
    expect(io).to receive(:puts).with "Carbonara £19.00"
    expect(io).to receive(:puts).with "TOTAL £39.00"
    menu.receipt([dish_1, dish_2])
  end

  it "calculates prep time for array of dishes" do
    io = double(:io)
    menu = Menu.new(io)
    dish_1 = double(:dish_1, name: "Hamburger", prep_time: 40)
    dish_2 = double(:dish_2, name: "Carbonara", prep_time: 35)
    time = Time.new(2022,8,23,16,0,0,"+00:00")
    expect(menu.get_prep_time([dish_1, dish_2], time)).to eq "16:40"
  end
end