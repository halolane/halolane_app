class AddUrlToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :url, :string
    add_index :profiles, :url, unique: :true
  end
end
