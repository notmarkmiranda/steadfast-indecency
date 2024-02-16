class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.string :body
      t.boolean :correct, default: nil
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
