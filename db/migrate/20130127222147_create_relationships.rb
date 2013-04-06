class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :profile_id
      t.string :description
      t.boolean :profile_admin

      t.timestamps
    end

    add_index :relationships, :user_id
    add_index :relationships, :profile_id
 	add_index :relationships, [:user_id, :profile_id], unique: true

  end
end
