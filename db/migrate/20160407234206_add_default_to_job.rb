class AddDefaultToJob < ActiveRecord::Migration
  def change
    change_column :jobs, :to_crawl, :integer, default: 0
    change_column :jobs, :crawled, :integer, default: 0
  end
end
