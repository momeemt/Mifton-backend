class CreateUserJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_jobs do |t|
      t.bigint :user_id
      t.boolean :admin, default: false
      t.boolean :manager, default: false
      t.boolean :staff, default: false
      t.boolean :trust_user, default: false

      t.boolean :crawl, default: false
      t.boolean :topic_writer, default: false
      t.boolean :web_developer, default: false
      t.boolean :app_developer, default: false
      t.boolean :public_relation, default: false
      t.boolean :director, default: false
      t.timestamps
    end
  end
end
