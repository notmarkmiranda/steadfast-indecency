class AddIndexToChoices < ActiveRecord::Migration[7.1]
  def change
    remove_index :choices, :question_id
    add_index :choices, :question_id, unique: true
  end
end
