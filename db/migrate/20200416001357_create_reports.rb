class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.bigint :user_id
      t.bigint :target_user_id
      t.integer :reports_type
      t.text :content
      t.timestamps
    end
  end
end
