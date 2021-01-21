require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :development

set :environment, :production
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '10:00 am' do # タスクを処理するペースを記載する。(例は1分ごとに実行）
  rake 'push:push_line_message'
end
