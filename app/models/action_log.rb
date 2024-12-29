class ActionLog < ApplicationRecord
  validates :issue_id, :action_type, :action_details, presence: true
end
