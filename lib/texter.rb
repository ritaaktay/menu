require 'twilio-ruby'
require 'dotenv/load'

class Texter
  def initialize(client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']))
    @client = client
  end

  def send_sms(body:,to:)
      @client.messages.create(
        from: '+18146374780',
        to: to,
        body: body
      )
  end
end