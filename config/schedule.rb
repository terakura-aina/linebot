require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: ['4:00 pm'] do
  rake 'push:push_line_message'
end

every 15.minutes do
  rake 'push:push_mission_inviter'
end