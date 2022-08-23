#in the unit test for texter, do I test with the API, or do I mock the API?
#couldn't figure out how to mock @client in a way that recieves message
#to return an object with a create method which returns the Twilio mock reply
#seems unnecessarily complicated
require 'texter'

RSpec.describe Texter do
  it "initializes with client" do
    expect(Texter.new).to be  
  end

  it "sends sms" do
    texter = Texter.new
    expect(texter.send_sms(body: "body", to: ENV['PHONE_NUM']).body).to eq "Sent from your Twilio trial account - body"
    expect(texter.send_sms(body: "body", to: ENV['PHONE_NUM']).to).to eq ENV['PHONE_NUM']
  end
end