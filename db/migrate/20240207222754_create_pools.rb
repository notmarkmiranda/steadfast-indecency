class CreatePools < ActiveRecord::Migration[7.1]
  def change
    create_table :pools do |t|
      t.string :name, null: false
      t.string :description
      t.date :cutoff_date
      t.date :event_date
      t.boolean :multiple_entries, default: false

      t.timestamps
    end
  end
end
