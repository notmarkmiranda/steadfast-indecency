class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.references :pool, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
