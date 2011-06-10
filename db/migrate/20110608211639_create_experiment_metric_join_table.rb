class CreateExperimentMetricJoinTable < ActiveRecord::Migration
  def self.up
    create_table :experiments_metrics, :id => false do |t|
	  t.integer :experiment_id
	  t.integer :metric_id
	end
  end

  def self.down
    drop_table :experiments_metrics
  end
end
