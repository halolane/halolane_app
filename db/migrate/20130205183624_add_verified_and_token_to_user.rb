class AddVerifiedAndTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :verified, :boolean
    add_column :users, :token, :string
  end
end
