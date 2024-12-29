class SyncStatesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Fetch states from linear and sync to db
    states = LinearApi.fetch_states
    states.each do |state|
      LinearState.where(name: state["name"]).first_or_create do |s|
        s.state_id = state["id"]
      end
    end

    # remove ones that no longer exist
    LinearState.where.not(name: states.map { |s| s["name"] }).destroy_all
  end
end
