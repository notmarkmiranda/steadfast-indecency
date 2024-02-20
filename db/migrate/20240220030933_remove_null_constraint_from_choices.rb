class RemoveNullConstraintFromChoices < ActiveRecord::Migration[7.1]
  def up
    change_column_null :choices, :option_id, true
  end

  def down
    change_column_null :choices, :option_id, false
  end
end
