class SchedulesController < ApplicationController
  require 'net/http'
  require 'uri'
  def index
    @schedules = Schedule.where('finish_planned_day_at > ?', Time.now).order(created_at: :desc)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @user = User.find(session[:user_id])
    @schedule = Schedule.new(schedule_params)
    if @schedule.update(token: SecureRandom.hex(32),inviter_id: @user.id)
      @schedule.update(token: SecureRandom.hex(32))
      render json: @schedule
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
    else
      render status: 400, json: { status: 400, message: 'Bad Request' }
    end
  end

  def edit
    @schedule = Schedule.find_by(token: params[:token])
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.update(answer: 1)
    render json: @schedule
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy!
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start_planned_day_at, :finish_planned_day_at, :place, :other, :inviter_id)
  end
end
