class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.date :deathday
      t.integer :privacy

      t.timestamps
    end
  end
end
