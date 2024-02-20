class AddQuestionIdToChoices < ActiveRecord::Migration[7.1]
  def change
    add_reference :choices, :question, null: false, foreign_key: true
  end
end
