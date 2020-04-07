class AddIndexToUsersUserId < ActiveRecord::Migration[6.0]
  def up
    add_index :users, :user_id, unique: true
  end
end
