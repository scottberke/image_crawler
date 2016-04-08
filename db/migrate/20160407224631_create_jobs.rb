class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :sidekiq_jid
      t.integer :to_crawl
      t.integer :crawled
      t.text :results

      t.timestamps null: false
    end
  end
end
