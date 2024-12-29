class SlaRule < ApplicationRecord
  enum :action_type, {
    comment: 0,
    update_status: 1,
    update_priority: 2
  }

  enum :filter_type, {
    priority: 0,
    label: 1,
    state: 2
  }

  validates :filter_type, :filter_value, :inactive_duration, :action_type, presence: true
end
