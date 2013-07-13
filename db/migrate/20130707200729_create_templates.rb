class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :description
      t.integer :height
      t.integer :width

      t.timestamps
    end
  end
end
