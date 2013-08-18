class AddPriceToPlans < ActiveRecord::Migration
  def change
  	remove_column :plans, :price
    add_column :plans, :price, :decimal, :precision => 8, :scale => 2
  end
end
