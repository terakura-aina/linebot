class SchedulesController < ApplicationController
  # CSRH対策で外部からのアクションを拒否されてしまうので、以下で対処
  protect_from_forgery :except => [:create]
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
