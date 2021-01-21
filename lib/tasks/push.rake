namespace :push do
  desc "push_line"
  task push_line_message: :environment do # 以下にpush機能のタスクを書く。
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
