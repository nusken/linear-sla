class SlaRule < ApplicationRecord
  enum action_type: {
    comment: 0,
    change_status: 1,
    flag: 2
  }

  enum filter_type: {
    by_tag: 0,
    by_priority: 1,
    by_status: 2
  }

  validates :filter_type, :filter_target, :inactive_duration, :action_type, presence: true
end
