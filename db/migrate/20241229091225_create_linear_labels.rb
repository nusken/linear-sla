class CreateLinearLabels < ActiveRecord::Migration[8.0]
  def change
    create_table :linear_labels do |t|
      t.string :name
      t.string :label_id

      t.timestamps
    end
  end
end
