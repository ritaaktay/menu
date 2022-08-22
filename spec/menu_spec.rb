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
end