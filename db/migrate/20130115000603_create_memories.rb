class CreateMemories < ActiveRecord::Migration
  def change
    create_table :memories do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end
