namespace :push do
  desc "push_line"

  task push_mission: :environment do
    schedules = Schedule.where('start_planned_day_at <= ? and finish_planned_day_at > ? and answer = ?', Time.now, Time.now, 1)
    inviter_mission = Mission.order("RANDOM()").first
    partner_mission = Mission.order("RANDOM()").first
    schedules.each do |schedule|
       # inviterにミッションを送る
      message = {
        type: 'text',
        text: "https://liff.line.me/1655592642-mxP7Mkkp/missions/#{schedule.token}/inviter"
      }
      client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV['LINE_CHANNEL_SECRET']
          config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(schedule.make_plan.inviter.line_user_id, message)
      p response

      # partnerにミッションを送る
      message = {
        type: 'text',
        text: "https://liff.line.me/1655592642-mxP7Mkkp/missions/#{schedule.token}/partner"
      }
      client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV['LINE_CHANNEL_SECRET']
          config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      }
      response = client.push_message(schedule.make_plan.partner.line_user_id, message)
      p response

      # TodayMissionテーブルにミッションを保存する
      TodayMission.create(schedule_id: schedule.id, mission_id: inviter_mission.id, user_id: schedule.make_plan.inviter.id, user_status: 0)
      TodayMission.create(schedule_id: schedule.id, mission_id: partner_mission.id, user_id: schedule.make_plan.partner.id, user_status: 1)
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
