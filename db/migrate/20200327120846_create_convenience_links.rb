class CreateConvenienceLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :convenience_links do |t|
      t.string :name
      t.text :description
      t.text :link
      t.boolean :is_public

      t.timestamps
    end
  end
end
