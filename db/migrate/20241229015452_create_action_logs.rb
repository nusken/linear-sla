class CreateActionLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :action_logs do |t|
      t.string :issue_id
      t.integer :action_type
      t.text :action_details
      t.timestamps
    end
  end
end
