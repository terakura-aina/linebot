class MakePlan < ApplicationRecord
  # invitedモデルを探しにいってしまうので、class_nameを指定してあげる
  belongs_to :invited, class_name: 'User'
  belongs_to :partner, class_name: 'User', optional: true
  belongs_to :schedule
end