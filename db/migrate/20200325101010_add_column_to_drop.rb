class AddColumnToDrop < ActiveRecord::Migration[6.0]
  def change
    add_column :drops, :user_id, :bigint, null: false
  end
end
