class Schedule < ApplicationRecord
  validates :start_planned_day_at, presence: true
  validates :finish_planned_day_at, presence: true
  validates :answer, presence: true
end
