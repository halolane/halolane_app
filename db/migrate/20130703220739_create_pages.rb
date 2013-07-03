class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :page_num
      t.integer :chapter_id

      t.timestamps
    end
  end
end
