class SyncLabelsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Fetch states from linear and sync to db
    labels = LinearApi.fetch_labels
    labels.each do |label|
      LinearLabel.where(name: label["name"]).first_or_create do |l|
        l.label_id = label["id"]
      end
    end

    # remove non-existing labels
    LinearLabel.where.not(name: labels.map { |l| l["name"] }).destroy_all
  end
end
