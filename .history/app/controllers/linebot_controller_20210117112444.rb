class LinebotController < ApplicationController
  require 'line/bot'

  protect_from_forgery :except => [:callback]

  def callback
    client = Line::Bot::Client.new { |config|
      config.channel_secret = 'LINE_CHANNEL_SECRET'
      config.channel_token = 'LINE_CHANNEL_TOKEN'
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
