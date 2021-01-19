class LinebotController < ApplicationController
  require 'line/bot'

  protect_from_forgery :except => [:callback]

  def liff; end

  def dateme; end

  def callback
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
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
          elsif event.message['text'] == 'こんばんは'
            client.reply_message(
              event['replyToken'],
              {
                type: 'text',
                text: 'こんばんは'
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
