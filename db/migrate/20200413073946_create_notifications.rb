class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.bigint :user_id
      t.bigint :ignition_user_id
      t.string :service
      t.string :type
      t.text :content
      t.timestamps
    end
  end
end
