class CreateSlaRules < ActiveRecord::Migration[8.0]
  def change
    create_table :sla_rules do |t|
      t.integer :filter_type
      t.string :filter_value
      t.integer :inactive_duration
      t.integer :action_type
      t.text :action_details
      t.timestamps
    end
  end
end
