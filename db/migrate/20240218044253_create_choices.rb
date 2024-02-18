class CreateChoices < ActiveRecord::Migration[7.1]
  def change
    create_table :choices do |t|
      t.references :option, null: false, foreign_key: true
      t.references :entry, null: false, foreign_key: true
      t.boolean :correct, default: nil

      t.timestamps
    end
  end
end
