class SchedulesController < ApplicationController
  require 'net/http'
  require 'uri'
  def index
  end

  def new
  end

  def create
    idToken = params[:idToken]
    channelId = '1655592642'
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'),
                          {'id_token'=>idToken, 'client_id'=>channelId})
    render :json => res.body

    @schedule = Schedule.new(schedule_params)
    @schedule.save!
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
