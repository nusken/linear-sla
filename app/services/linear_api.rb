require "graphql/client/http"

class LinearApi
  def fetch_issues(filter_type:, filter_target:)
    # Execute query and return issues
    filter_object = {}
    filter_object[filter_type] = {
      eq: filter_target
    }
    execute_query(Linear::FETCH_ISSUE_QUERY, {
      filter: filter_object
    }).dig("issues", "nodes")
  end

  def fetch_states(name: nil)
    if name.present?
      filter = {
        name: { eq: name }
      }
    else
      filter = {}
    end

    execute_query(Linear::FETCH_STATE_QUERY, filter: filter).dig("workflowStates", "nodes")
  end

  def comment(issue_id:, comment: "")
    execute_mutation(Linear::COMMENT_MUTATION, {
      issueId: issue_id,
      comment: comment
    }).comment_create
  end

  def change_status(issue_id:, status_id:)
    execute_mutation(Linear::CHANGE_STATUS_MUTATION, {
      issueId: issue_id,
      statusId: status_id
    }).issue_update
  end


  private

  def execute_query(query, variables = {})
    Linear::Client.query(query, variables: variables).original_hash["data"]
  end

  def execute_mutation(mutation, variables = {})
    Linear::Client.query(mutation, variables: variables).data
  end
end
