class CreateMemoryphotos < ActiveRecord::Migration
  def change
    create_table :memoryphotos do |t|
      t.integer :memory_id

      t.timestamps
    end
  end
end
