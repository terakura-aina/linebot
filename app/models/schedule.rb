class Schedule < ApplicationRecord
  has_many :make_plans, dependent: :destroy

  validates :start_planned_day_at, presence: true
  validates :finish_planned_day_at, presence: true
  validates :answer, presence: true
end
