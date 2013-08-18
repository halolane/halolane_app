class AddUserIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :user_id, :integer
    remove_column :subscriptions, :email
  end
end
