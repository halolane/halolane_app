class CreateEmailsubscriptions < ActiveRecord::Migration
  def change
    create_table :emailsubscriptions do |t|
      t.integer :user_id
      t.integer :emailperweek

      t.timestamps
    end
  end
end
