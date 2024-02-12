class ChangeActiveDefaultOnMemberships < ActiveRecord::Migration[7.1]
  def change
    change_column_default :memberships, :active, false
  end
end
