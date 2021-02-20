class TodayMission < ApplicationRecord
  belongs_to :schedule
  belongs_to :inviter_mission, class_name: 'Mission'
  belongs_to :partner_mission, class_name: 'Mission'

  enum inviter: { until: 0, done: 1 }
  enum partner: { yet: 0, end: 1 }
end
