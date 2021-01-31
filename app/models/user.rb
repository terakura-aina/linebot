class User < ApplicationRecord
  has_many :asks, class_name: 'MakePlan', foreign_key: 'invited_id', dependent: :destroy
  has_many :answers, class_name: 'MakePlan', foreign_key: 'partner_id', dependent: :destroy
  has_many :partner, through: :asks, source: :partner
end
