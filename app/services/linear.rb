require "graphql/client"
require "graphql/client/http"

# Star Wars API example wrapper
module Linear
  # Configure GraphQL endpoint using the basic HTTP network adapter.
  HTTP = GraphQL::Client::HTTP.new(Rails.application.credentials.linear_api[:endpoint]) do
    def headers(context)
      {
        "Authorization" => Rails.application.credentials.linear_api[:api_key]
      }
    end
  end


  Schema = GraphQL::Client.load_schema("db/graphql/schema.json")

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

  # Priorty enum
  PRIORITY = {
    "None" => 0,
    "Urgent" => 1,
    "High" => 2,
    "Medium" => 3,
    "Low" => 4
  }

  # QUERIES
  FETCH_ISSUE_QUERY = Client.parse <<~GRAPHQL
    query($filter: IssueFilter) {
      issues(
        filter: $filter
      ) {
        nodes {
          id
          title
          priority
          state {
            name
          }
          updatedAt
        }
      }
    }
  GRAPHQL

  FETCH_STATE_QUERY = Client.parse <<~GRAPHQL
    query($filter: WorkflowStateFilter) {
      workflowStates(filter: $filter) {
        nodes {
          id
          name
        }
      }
    }
  GRAPHQL

  # MUTATIONS
  COMMENT_MUTATION = Client.parse <<~GRAPHQL
    mutation($issueId: String!, $comment: String!) {
      commentCreate(
        input: {
          issueId: $issueId,
          body: $comment
        }
      ) {
        success
      }
    }
  GRAPHQL

  CHANGE_STATUS_MUTATION = Client.parse <<~GRAPHQL
    mutation($issueId: String!, $statusId: String!) {
      issueUpdate(
        id: $issueId,
        input: {
          stateId: $statusId
        }
      ) {
        success
      }
    }
  GRAPHQL

  UPDATE_PRIORITY_MUTATION = Client.parse <<~GRAPHQL
    mutation($issueId: String!, $priority: Int!) {
      issueUpdate(
        id: $issueId,
        input: {
          priority: $priority
        }
      ) {
        success
      }
    }
  GRAPHQL
end
