class TwiliosController < ApplicationController
  
  def send_article

    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
            
    message = @client.account.messages.create(
    :from => @twilio_number,
    :to => params["phone_number"],
    :body => params["article_url"]
    )

  end

end
