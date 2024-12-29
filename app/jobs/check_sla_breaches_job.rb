class CheckSlaBreachesJob < ApplicationJob
  def perform
    SlaRule.find_each do |rule|
      matching_issues = LinearApi.fetch_issues(
        filter_type: rule.filter_type,
        filter_value: rule.filter_value,
        inactive_duration: rule.inactive_duration
      )

      matching_issues.each do |issue|
        apply_action(issue, rule)
      end
    end
  end

  private

  def apply_action(issue, rule)
    case rule.action_type
    when "comment"
      LinearApi.comment(issue_id: issue["id"], comment: rule.action_details)
    when "update_status"
      status = LinearState.where(name: rule.action_details).first

      if status.present?
        LinearApi.update_status(issue_id: issue["id"], status_id: status.linear_id)
      else
        Rails.logger.error "Status not found: #{rule.action_details}"
      end
    when "update_priority"
      LinearApi.update_priority(issue_id: issue["id"], priority: rule.action_details)
    end

    ActionLog.create(
      issue_id: issue["id"],
      action_type: rule.action_type,
      action_details: rule.action_details
    )
  end
end
