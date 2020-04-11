class CreateOptionalUserData < ActiveRecord::Migration[6.0]
  def change
    create_table :optional_user_data do |t|
      t.bigint :user_id
      t.text :profile
      t.string :website
      t.string :location
      t.datetime :birthday
      t.boolean :publish_birthday
      t.string :twitter_id
      t.string :lobi_id
      t.string :github_id
      t.string :discord_id
      t.timestamps
    end
  end
end
