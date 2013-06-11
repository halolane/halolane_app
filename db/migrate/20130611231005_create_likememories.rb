class CreateLikememories < ActiveRecord::Migration
  def change
    create_table :likememories do |t|
      t.integer :user_id
      t.integer :memory_id
      t.timestamps
    end
  end
end
