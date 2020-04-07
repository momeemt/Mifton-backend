class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.bigint :user_id
      t.timestamps
    end
  end
end
