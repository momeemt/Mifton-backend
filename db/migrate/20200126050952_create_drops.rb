class CreateDrops < ActiveRecord::Migration[6.0]
  def change
    create_table :drops do |t|
      t.text :content

      t.timestamps
    end
  end
end
