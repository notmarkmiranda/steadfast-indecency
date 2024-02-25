class RemoveQuestionIndexFromChoices < ActiveRecord::Migration[7.1]
  def up
    remove_index :choices, :question_id
  end

  def down
    add_index :choices, :question_id
  end
end
