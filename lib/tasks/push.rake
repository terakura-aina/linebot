namespace :push do
  desc "push_line"

  task push_mission_inviter: :environment do
    schedules = Schedule.where('start_planned_day_at <= ? and finish_planned_day_at > ? and answer = ?', Time.now, Time.now, 1)
    schedules.each do |schedule|
      message = {
        type: 'text',
        text: Mission.order("RANDOM()").first.body
      }
      client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV['LINE_CHANNEL_SECRET']
          config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(schedule.make_plan.inviter.line_user_id, message)
      p response
    end
  end

  task push_line_message: :environment do
    message = {
      type: 'text',
      text: '今日も頑張ろう！'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    response = client.push_message(ENV['LINE_CHANNEL_USER_ID'], message)
    p response
  end
end
