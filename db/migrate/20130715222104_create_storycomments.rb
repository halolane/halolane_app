class CreateStorycomments < ActiveRecord::Migration
  def change
    create_table :storycomments do |t|
      t.integer :user_id
      t.integer :memory_id
      t.string :content

      t.timestamps
    end
  end
end
