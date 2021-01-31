class SchedulesController < ApplicationController
  require 'net/http'
  require 'uri'
  def index
  end

  def show
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.save!
    message = {
      "type": "text",
      "text": "デートのお誘いをしています！\nお返事があるまでお待ちください $",
      "emojis": [
        {
          "index": 31,
          "productId": "5ac1bfd5040ab15980c9b435",
          "emojiId": "001"
        }
      ]
  }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    response = client.push_message(ENV['LINE_CHANNEL_USER_ID'], message)
    p response
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start_planned_day_at, :finish_planned_day_at, :place, :other)
  end
end
