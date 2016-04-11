class AddLimitForResultsToJobs < ActiveRecord::Migration
  def change
    change_column :jobs, :results, :text, :limit => 4294967295
  end
end
