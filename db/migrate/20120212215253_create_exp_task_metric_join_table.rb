class CreateExpTaskMetricJoinTable < ActiveRecord::Migration
  def self.up
    create_table :exp_tasks_metrics, :id => false do |t|
	  t.integer :exp_task_id
	  t.integer :metric_id
	end
  end

  def self.down
    drop_table :exp_tasks_metrics
  end
end
