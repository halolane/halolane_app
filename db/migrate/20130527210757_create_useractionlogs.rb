class CreateUseractionlogs < ActiveRecord::Migration
  def change
    create_table :useractionlogs do |t|

      t.timestamps
    end
  end
end
