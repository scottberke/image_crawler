class DecreaseLimitForResultsToJobs < ActiveRecord::Migration
  def change
    change_column :jobs, :results, :text, :limit => 1073741823
  end
end
