class UpdateCutoffAndEventDatesToDatetime < ActiveRecord::Migration[7.1]
 def up
    change_column :pools, :cutoff_date, :datetime
    change_column :pools, :event_date, :datetime
  end

  def down
    change_column :pools, :cutoff_date, :date
    change_column :pools, :event_date, :date
  end
end
