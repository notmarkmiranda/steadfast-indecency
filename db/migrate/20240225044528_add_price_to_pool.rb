class AddPriceToPool < ActiveRecord::Migration[7.1]
  def change
    add_column :pools, :price, :integer, default: 0
  end
end
