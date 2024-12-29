require "graphql/client/http"

class LinearApi
  def self.fetch_issues(filter_type:, filter_value:, inactive_duration:)
    last_updated = Time.now - inactive_duration.hours

    filter_object = generate_filter_object(filter_type, filter_value)

    filter_object[:updatedAt] = {
      lt: last_updated.iso8601
    }

    execute_query(Linear::FETCH_ISSUE_QUERY, {
      filter: filter_object
    }).dig("issues", "nodes")
  end

  def self.fetch_states(name: nil)
    if name.present?
      filter = {
        name: { eq: name }
      }
    else
      filter = {}
    end

    execute_query(Linear::FETCH_STATE_QUERY, filter: filter).dig("workflowStates", "nodes")
  end

  def self.comment(issue_id:, comment: "")
    execute_mutation(Linear::COMMENT_MUTATION, {
      issueId: issue_id,
      comment: comment
    }).comment_create
  end

  def self.update_status(issue_id:, status_id:)
    execute_mutation(Linear::CHANGE_STATUS_MUTATION, {
      issueId: issue_id,
      statusId: status_id
    }).issue_update
  end

  def self.update_priority(issue_id:, priority:)
    execute_mutation(Linear::UPDATE_PRIORITY_MUTATION, {
      issueId: issue_id,
      priority: priority.to_i
    }).issue_update
  end


  private

  def self.execute_query(query, variables = {})
    Linear::Client.query(query, variables: variables).original_hash["data"]
  end

  def self.execute_mutation(mutation, variables = {})
    Linear::Client.query(mutation, variables: variables).data
  end

  def self.generate_filter_object(filter_type, filter_value)
    filter_object = {}
    if filter_type == "state"
      filter_object = {
        state: {
          name: {
            eq: filter_value
          }
        }
      }

    elsif filter_type == "label"
      filter_object = {
        labels: {
          some: {
            name: {
              eq: filter_value
            }
          }
        }
      }
    else
      filter_object[filter_type] = {
        eq: filter_value
      }
    end

    filter_object
  end
end
