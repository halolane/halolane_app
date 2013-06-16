class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.integer :profile_id
      t.string :chapter_name
      t.integer :chapter_num

      t.timestamps
    end
  end
end
