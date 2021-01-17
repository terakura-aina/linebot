class LinebotController < ApplicationController
  require 'line/bot'

  protect_from_forgery :except => [:callback]

  def callback
    client = Line::Bot::Client.new { |config|
      config.channel_secret = '9e53ebbbc6bfa852a964b7b2e8867b1b'
      config.channel_token = 'e7L6f2Dzg6m94SujL4n7iGjQWlHHeaUHLWtFRTve57k26S2inTmxoDYhlXcl4PXWW/LBqveZQ3E5xGaRvUUodEjKM2iMuXukYQddqjh71xaC0ka1c+A+n1Aixp9esW+lEvjzDeZmlKTHITn9NjqTVwdB04t89/1O/w1cDnyilFU='
    }
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message['text'] == 'こんにちは'
            client.reply_message(
              event['replyToken'],
              {
                type: 'text',
                text: 'こんにちは'
              }
            )
          else
            client.reply_message(
              event['replyToken'],
              {
                type: 'text',
                text: 'すいません。よくわかりません。'
              }
            )
          end
        end
      end
    }
    head :ok
  end
end
