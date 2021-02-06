class Schedule < ApplicationRecord
  has_many :make_plans, dependent: :destroy
  belongs_to :inviter, class_name: 'User'

  validates :start_planned_day_at, presence: true
  validates :finish_planned_day_at, presence: true
  validates :answer, presence: true
end
