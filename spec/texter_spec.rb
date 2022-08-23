#in the unit test for texter, do I test with the API, or do I mock the API?
#couldn't figure out how to mock @client in a way that recieves message
#to return an object with a create method which returns the Twilio mock reply
#seems unnecessarily complicated

require 'texter'

RSpec.describe Texter do
  it "initializes with client" do
    expect(Texter.new).to be  
  end

  it "fails if no client is given" do
    texter = Texter.new(nil)
    expect{ texter.send_sms(body: "body", to: "+11111111") }.to raise_error "no client"
  end
end