class CreateLinearStates < ActiveRecord::Migration[8.0]
  def change
    create_table :linear_states do |t|
      t.string :name
      t.string :state_id

      t.timestamps
    end
  end
end
