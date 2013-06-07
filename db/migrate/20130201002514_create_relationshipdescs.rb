class CreateRelationshipdescs < ActiveRecord::Migration
  def change
    create_table :relationshipdescs do |t|
      t.string :description

      t.timestamps
    end
  end
end
